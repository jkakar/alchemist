defmodule Alchemist do
  @moduledoc """
  Carefully refactor critical paths.

  Run an experiment all the time:

  ```
  alchemy "experiment" do
    # Candidate code block is run
  else
    # Control code block is ignored
  end
  ```

  Run an experiment only when a condition is met:

  ```
  alchemy "experiment", enable: false do
    # Candidate code block is ignored
  else
    # Control code block is run
  end
  ```

  Run an experiment some percentage of the time:

  ```
  alchemy "experiment", probability: 0.01 do
    # Candidate code block runs 1% of the time
  else
    # Control code block runs 99% of the time
  end
  ```
  """

  defmacro __using__(_) do
    quote do
      import Alchemist
    end
  end

  defmacro alchemy(name, options \\ [], clauses) do
    enable = Keyword.get(options, :enable, true)
    probability = Keyword.get(options, :probability)
    clauses = Keyword.merge(clauses, [probability: probability])
    build_alchemy(name, enable, clauses)
  end

  defp build_alchemy(name, condition, do: do_clause, else: else_clause, probability: probability) do
    quote do
      name = unquote(name)
      condition = unquote(condition)
      probability = unquote(probability)

      condition = case probability do
        nil -> condition
        _ -> case condition do
          false -> false
          _ -> :rand.uniform <= probability
        end
      end

      {time, result} = :timer.tc(fn ->
        case condition do
          x when x in [false, nil] -> unquote(else_clause)
          _ -> unquote(do_clause)
        end
      end)

      # Alchemist.Publish.publish(name, %{duration: time})
      result
    end
  end

  defp build_alchemy(_name, _condition, _arguments) do
    raise(ArgumentError, "invalid or duplicate keys for alchemy, only " <>
                         "\"do\" and \"else\" are permitted")
  end
end

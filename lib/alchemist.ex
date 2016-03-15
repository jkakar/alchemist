defmodule Scientist do
  @moduledoc """
  Run an experiment all the time:

  ```
  science "experiment" do
    # Experimental code block is run
  else
    # Control code block is ignored
  end
  ```

  Run an experiment only when a condition is met:

  ```
  science "experiment", enable: false do
    # Experimental code block is ignored
  else
    # Control code block is run
  end
  ```

  Run an experiment some percentage of the time:

  ```
  science "experiment", probability: 0.01 do
    # Control code block runs 99% of the time
  try
    # Experimental code block runs 1% of the time
  end
  ```
  """

  defmacro __using__(_) do
    quote do
      import Scientist
    end
  end

  defmacro science(_name, options \\ [], clauses) do
    enable = Keyword.get(options, :enable, true)
    probability = Keyword.get(options, :probability)
    clauses = Keyword.merge(clauses, [probability: probability])
    build_science(enable, clauses)
  end

  defp build_science(condition, do: do_clause, else: else_clause, probability: probability) do
    quote do
      condition = unquote(condition)
      probability = unquote(probability)

      condition = case probability do
        nil -> condition
        _ -> case condition do
          false -> false
          _ -> :rand.uniform <= probability
        end
      end

      case condition do
        x when x in [false, nil] -> unquote(else_clause)
        _ -> unquote(do_clause)
      end
    end
  end

  defp build_science(_condition, _arguments) do
    raise(ArgumentError, "invalid or duplicate keys for science, only " <>
                         "\"do\" and \"else\" are permitted")
  end
end

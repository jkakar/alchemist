defmodule AlchemistTest do
  use ExUnit.Case
  import ExUnit.CaptureLog
  use Alchemist
  doctest Alchemist

  test "alchemy/3 macro runs candidate code by default" do
    Logger.configure(level: :warn)
    result = alchemy "experiment" do
      "candidate"
    else
      "control"
    end
    assert result == "candidate"
  end

  test "alchemy/3 macro runs control code when the enable option is false" do
    Logger.configure(level: :warn)
    result = alchemy "experiment", enable: false do
      "candidate"
    else
      "control"
    end
    assert result == "control"
  end

  test "alchemy/3 macro can randomly choose whether to run candidate code based on a given probability" do
    Logger.configure(level: :warn)
    result = 0..100
    |> Enum.map(fn(_) ->
      alchemy "experiment", probability: 0.25 do
        "candidate"
      else
        "control"
      end
    end)
    |> Enum.uniq
    |> Enum.sort
    assert result == ["candidate", "control"]
  end

  test "alchemy/3 macro ignores the probability option when the enable option is false" do
    Logger.configure(level: :warn)
    result = 0..100
    |> Enum.map(fn(_) ->
      alchemy "experiment", enable: false, probability: 0.25 do
        "candidate"
      else
        "control"
      end
    end)
    |> Enum.uniq
    |> Enum.sort
    assert result == ["control"]
  end
end

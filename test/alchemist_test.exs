defmodule AlchemistTest do
  use ExUnit.Case
  import ExUnit.CaptureLog
  use Alchemist
  doctest Alchemist

  test "alchemy/3 runs candidate code by default" do
    result = alchemy "experiment" do
      "candidate"
    else
      "control"
    end
    assert result == "candidate"
  end

  test "alchemy/3 runs control code when the enable option is false" do
    result = alchemy "experiment", enable: false do
      "candidate"
    else
      "control"
    end
    assert result == "control"
  end

  test "alchemy/3 can randomly choose whether to run candidate code based on a given probability" do
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

  test "alchemy/3 ignores the probability option when the enable option is false" do
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

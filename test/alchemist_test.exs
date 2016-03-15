defmodule ScientistTest do
  use ExUnit.Case
  use Scientist
  doctest Scientist

  test "science/3 macro runs experimental code by default" do
    result = science "experiment" do
      "experiment"
    else
      "control"
    end
    assert result == "experiment"
  end

  test "science/3 macro runs control code when the enable option is false" do
    result = science "experiment", enable: false do
      "experiment"
    else
      "control"
    end
    assert result == "control"
  end

  test "science/3 macro can randomly choose whether to run experimental code based on a given probability" do
    result = 0..100
    |> Enum.map(fn(_) ->
      science "experiment", probability: 0.25 do
        "experiment"
      else
        "control"
      end
    end)
    |> Enum.uniq
    |> Enum.sort
    assert result == ["control", "experiment"]
  end

  test "science/3 macro ignores the probability option when the enable option is false" do
    result = 0..100
    |> Enum.map(fn(_) ->
      science "experiment", enable: false, probability: 0.25 do
        "experiment"
      else
        "control"
      end
    end)
    |> Enum.uniq
    |> Enum.sort
    assert result == ["control"]
  end
end

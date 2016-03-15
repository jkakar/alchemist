defmodule AlchemistTest do
  use ExUnit.Case
  use Alchemist
  doctest Alchemist

  test "transmute/3 macro runs experimental code by default" do
    result = transmute "experiment" do
      "experiment"
    else
      "control"
    end
    assert result == "experiment"
  end

  test "transmute/3 macro runs control code when the enable option is false" do
    result = transmute "experiment", enable: false do
      "experiment"
    else
      "control"
    end
    assert result == "control"
  end

  test "transmute/3 macro can randomly choose whether to run experimental code based on a given probability" do
    result = 0..100
    |> Enum.map(fn(_) ->
      transmute "experiment", probability: 0.25 do
        "experiment"
      else
        "control"
      end
    end)
    |> Enum.uniq
    |> Enum.sort
    assert result == ["control", "experiment"]
  end

  test "transmute/3 macro ignores the probability option when the enable option is false" do
    result = 0..100
    |> Enum.map(fn(_) ->
      transmute "experiment", enable: false, probability: 0.25 do
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

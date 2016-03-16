defmodule Alchemist.ResultTest do
  use ExUnit.Case

  test "Alchemist.Result.matched?/1 returns true if the candidate and control paths returned the same value" do
    result = %Alchemist.Result{name: "test",
                               candidate: [result: 42],
                               control: [result: 42]}
    assert Alchemist.Result.matched?(result) == true
  end
end

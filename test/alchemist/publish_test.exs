defmodule Alchemist.PublishTest do
  use ExUnit.Case, async: false
  import ExUnit.CaptureLog

  test "Alchemist.Publish.publish/2 converts experiment results into a set of key/value pairs and writes them out to the log" do
    output = capture_log(fn ->
      result = %Alchemist.Result{name: "experiment",
                                 candidate: [duration: 10928, value: 42],
                                 control: [duration: 9384, value: 42]}
      Alchemist.Publish.publish(result)
    end)
    assert output =~ "alchemist.experiment.candidate.duration=10928"
    assert output =~ "alchemist.experiment.candidate.value=42"
    assert output =~ "alchemist.experiment.control.duration=9384"
    assert output =~ "alchemist.experiment.control.value=42"
    assert output =~ "alchemist.experiment.matched=1"
    assert output =~ "alchemist.experiment.mismatched=0"
  end
end

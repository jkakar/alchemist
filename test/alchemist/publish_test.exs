defmodule Alchemist.PublishTest do
  use ExUnit.Case
  import ExUnit.CaptureLog

  test "Alchemist.Publish.publish/2 converts experiment results into a set of key/value pairs and writes them out to the log" do
    output = capture_log(fn ->
      result = %Alchemist.Result{name: "experiment",
                                 candidate: [duration: 10928],
                                 control: [duration: 9384]}
      Alchemist.Publish.publish(result)
    end)
    assert output =~ "alchemist.experiment.candidate.duration=10928"
    assert output =~ "alchemist.experiment.control.duration=9384"
  end
end

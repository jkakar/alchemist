defmodule Alchemist.PublishTest do
  use ExUnit.Case, async: false
  import ExUnit.CaptureLog

  test "Alchemist.Publish.publish/1 writes experiment results to the log" do
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
    assert output =~ "alchemist.experiment.ignored=0"
    assert output =~ "alchemist.experiment.run=1"
  end

  test "Alchemist.Publish.publish/1 writes ignore counts to the log when the experiment is skipped" do
    output = capture_log(fn ->
      result = %Alchemist.Result{name: "experiment",
                                 control: [duration: 9384, value: 42]}
      Alchemist.Publish.publish(result)
    end)
    assert !(output =~ "alchemist.experiment.candidate.duration=10928")
    assert !(output =~ "alchemist.experiment.candidate.value=42")
    assert output =~ "alchemist.experiment.control.duration=9384"
    assert output =~ "alchemist.experiment.control.value=42"
    assert !(output =~ "alchemist.experiment.matched=0")
    assert !(output =~ "alchemist.experiment.mismatched=0")
    assert output =~ "alchemist.experiment.ignored=1"
    assert output =~ "alchemist.experiment.run=0"
  end

  test "Alchemist.Publish.publish/1 writes context observations to the log when they're provided" do
    output = capture_log(fn ->
      result = %Alchemist.Result{name: "experiment",
                                 context: [username: "jkakar"],
                                 control: [duration: 9384, value: 42]}
      Alchemist.Publish.publish(result)
    end)
    assert output =~ "alchemist.experiment.context.username=jkakar"
  end
end

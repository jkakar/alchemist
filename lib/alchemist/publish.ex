defmodule Alchemist.Publish do
  require Logger

  @behaviour Alchemist.Publisher

  def publish(result) do
    candidate = get_observations(result.name, :candidate, result.candidate)
    control = get_observations(result.name, :control, result.control)
    wub = [candidate, control]
    |> List.flatten
    |> Enum.intersperse(" ")
    |> Logger.info
  end

  defp get_observations(name, branch, observations) do
    observations
    |> Enum.map(fn {k, v} -> "alchemist.#{name}.#{branch}.#{k}=#{v}" end)
  end
end

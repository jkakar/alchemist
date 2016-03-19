defmodule Alchemist.Publish do
  require Logger

  @behaviour Alchemist.Publisher

  def publish(result) do
    candidate = get_observations(result.name, :candidate, result.candidate)
    control = get_observations(result.name, :control, result.control)
    matches = get_match_observations(result)
    [candidate, control, matches]
    |> List.flatten
    |> Enum.intersperse(" ")
    |> Logger.info
  end

  defp get_observations(name, branch, observations) do
    observations
    |> Enum.map(fn {k, v} -> "alchemist.#{name}.#{branch}.#{k}=#{v}" end)
  end

  defp get_match_observations(result) do
    matches = Alchemist.Result.matched?(result)
    [matched?(result.name, matches),
     mismatched?(result.name, !matches)]
  end

  defp matched?(name, true),     do: "alchemist.#{name}.matched=1"
  defp matched?(name, false),    do: "alchemist.#{name}.matched=0"

  defp mismatched?(name, true),  do: "alchemist.#{name}.mismatched=1"
  defp mismatched?(name, false), do: "alchemist.#{name}.mismatched=0"
end

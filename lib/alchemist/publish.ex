defmodule Alchemist.Publish do
  require Logger

  @behaviour Alchemist.Publisher

  def publish(result) do
    ignored = Alchemist.Result.ignored?(result)
    [get_branch_observations(result),
     get_context_observations(result),
     get_match_observations(result, ignored),
     get_run_observations(result, ignored)]
    |> List.flatten
    |> Enum.intersperse(" ")
    |> Logger.info
  end

  defp get_branch_observations(result) do
    [get_branch_observation(result.name, :candidate, result.candidate),
     get_branch_observation(result.name, :control, result.control)]
  end

  defp get_branch_observation(name, branch, observations) do
    observations
    |> Enum.map(fn {k, v} -> "alchemist.#{name}.#{branch}.#{k}=#{v}" end)
  end

  defp get_context_observations(result) do
    result.context
    |> Enum.map(fn {k, v} -> "alchemist.#{result.name}.context.#{k}=#{v}" end)
  end

  defp get_match_observations(result, ignored) do
    case ignored do
      true -> []
      _    -> matches = Alchemist.Result.matched?(result)
              [matched?(result.name, matches),
               mismatched?(result.name, !matches)]
    end
  end

  defp matched?(name, true),     do: "alchemist.#{name}.matched=1"
  defp matched?(name, false),    do: "alchemist.#{name}.matched=0"

  defp mismatched?(name, true),  do: "alchemist.#{name}.mismatched=1"
  defp mismatched?(name, false), do: "alchemist.#{name}.mismatched=0"

  defp get_run_observations(result, ignored) do
    case ignored do
      true  -> ["alchemist.#{result.name}.ignored=1",
                "alchemist.#{result.name}.run=0"]
      false -> ["alchemist.#{result.name}.ignored=0",
                "alchemist.#{result.name}.run=1"]
    end
  end
end

defmodule Alchemist.Result do
  defstruct name: nil,
            context: [],
            candidate: [],
            control: []

  def matched?(result) do
    candidate = result.candidate[:value]
    control = result.control[:value]
    candidate == control
  end

  def ignored?(result) do
    result.candidate == []
  end
end

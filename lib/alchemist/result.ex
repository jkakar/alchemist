defmodule Alchemist.Result do
  defstruct name: nil,
            candidate: [],
            control: []

  def matched?(result) do
    candidate = result.candidate[:result]
    control = result.control[:result]
    candidate == control
  end
end

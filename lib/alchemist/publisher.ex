defmodule Alchemist.Publisher do
  @callback publish(String.t, map()) :: none
end

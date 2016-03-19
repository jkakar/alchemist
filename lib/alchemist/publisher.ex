defmodule Alchemist.Publisher do
  @callback publish(Alchemist.Result.t) :: none
end

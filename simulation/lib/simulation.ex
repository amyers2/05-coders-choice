defmodule Simulation do
  
  alias Simulation.Impl
  
  defdelegate run(), to: Impl
  
end

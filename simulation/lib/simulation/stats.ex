defmodule Simulation.Stats do
  
  defstruct(
    wins:       0,
    ties:       0,
    losses:     0,
    busts:      0,
    net_losses: 0,
  )
  
  defimpl String.Chars, for: Simulation.Stats do
    def to_string(stats) do
      "#{stats.wins}"
      <> "\t\t#{stats.ties}"
      <> "\t\t#{stats.busts}"
      <> "\t\t#{stats.losses}"
      <> "\t\t#{stats.net_losses}"
    end
  end
  
end

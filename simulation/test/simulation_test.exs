defmodule SimulationTest do
  use ExUnit.Case
  doctest Simulation
  
  alias Simulation.Impl
  alias Simulation.Stats
  
  test "min losses" do
    assert {18, 2} == Impl.get_min_losses({16, 23}, {18, 2})
    assert {14, 7} == Impl.get_min_losses({14, 7}, {15, 8})
  end
  
  test "get count" do
    list = [:won, :won, :lost, :bust, :bust, :bust, :lost, :bust,
            :tie, :won, :bust, :lost, :lost, :lost, :lost, :lost]
            
    assert 1 == Impl.get_count(list, :tie)
    assert 3 == Impl.get_count(list, :won)
    assert 5 == Impl.get_count(list, :bust)
    assert 7 == Impl.get_count(list, :lost)
  end
  
  test "net_losses" do
    stats = %Stats{wins: 10, busts: 8, losses: 7}
      |> Impl.calc_net_losses()
    assert 5 == stats.net_losses
    
    stats = %Stats{wins: 10, busts: 2, losses: 4}
      |> Impl.calc_net_losses()
    assert -4 == stats.net_losses
  end
  
end

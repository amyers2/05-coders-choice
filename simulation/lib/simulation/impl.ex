defmodule Simulation.Impl do
  
  alias Simulation.State
  alias Simulation.Stats
  
  @targets 10..21
  @games 10000
  @hands 100
  
  
  # ~~~ display functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  def run() do
    IO.puts simulation_message()
    IO.puts table_header()
    IO.puts table_separator()
  
    Enum.map(@targets, &run_target_simulations/1)
      |> Enum.reduce(&get_min_losses/2)
      |> print_best_strategy()
  end
  
  defp simulation_message() do
    "\n\n"
    <> "Each target hand is simulating...\n\n"
    <> "  #{@games} simultaneous Blackjack games of #{@hands} hands each,\n"
    <> "  where the player stands when their hand count is >= target:\n\n"
  end
  
  defp table_header() do
    "  "
    <> "target hand"      <> "\twinning hands" <> "\t\"tie\" hands"
    <> "\t\"bust\" hands" <> "\tlosing hands"  <> "\tnet losses"
  end
  
  defp table_separator() do
    "  "
    <> first_line() <> table_line() <> table_line()
    <> table_line() <> table_line() <> table_line()
  end
  
  defp print_best_strategy({target, _net_losses}) do
    IO.puts "\n"
    IO.puts "Based on this simulation...\n"
    IO.puts "  Optimal target count for least net losses: #{target}"
  end
  
  defp first_line(), do: "------------- "
  defp table_line(), do: "--------------- "
  
  
  defp get_min_losses({x1, y1}, {_x2, y2}) when (y1 < y2) do
    {x1, y1}
  end
  
  defp get_min_losses(_result_1, result_2) do
    result_2
  end
  
  
  # ~~~ simulator functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp run_target_simulations(target) do
    stats = 1..@games
      |> Enum.map(&spawn_hand(&1, target))
      |> Enum.map(&recv_game_results/1)
      |> Enum.concat()
      |> get_stats()
      |> display_results(target)
      
    {target, stats.net_losses}
  end
  
  defp spawn_hand(_, target) do
    Task.async(__MODULE__, :simulate_hand, [target])
  end
  
  defp recv_game_results(pid) do
    Task.await(pid, :infinity)
  end
  
  defp get_stats(results) do
    %Stats{
      wins:   get_count(results, :won),
      ties:   get_count(results, :tie),
      losses: get_count(results, :lost),
      busts:  get_count(results, :bust),
    }
    |> calc_net_losses()
  end
  
  defp get_count(results, state) do
    Enum.count(results, &(&1 == state))
  end
  
  defp calc_net_losses(stats) do
    Map.put(stats, :net_losses, stats.busts + stats.losses - stats.wins)
  end
  
  defp display_results(stats, target) do
    IO.puts \
      "  #{target}" <>
      "\t\t#{stats.wins}" <>
      "\t\t#{stats.ties}" <>
      "\t\t#{stats.busts}" <>
      "\t\t#{stats.losses}" <>
      "\t\t#{stats.net_losses}"
    stats
  end
  
  
  # ~~~ hand execution functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  def simulate_hand(target) do
    sim = %State{target: target, hands: 1}
  
    Blackjack.new_game() 
      |> Blackjack.table()
      |> play_hand(sim)
  end
  
  
  defp play_hand({game, table = %{game_state: :in_progress}}, sim) do
    determine_action(game, table.player_count, sim.target)
      |> Blackjack.table()
      |> play_hand(sim)
  end
  
  defp play_hand({_game, table}, _sim = %{hands: @hands}) do
    [table.game_state]
  end
  
  defp play_hand({game, table}, sim) do
    sim = Map.put(sim, :hands, sim.hands + 1)
  
    next_result = game
      |> Blackjack.new_hand()
      |> Blackjack.table()
      |> play_hand(sim)
      
    [table.game_state | next_result]
  end
  
  
  defp determine_action(game, count, target) when (count < target) do
    Blackjack.hit(game)
  end
  
  defp determine_action(game, _, _) do
    Blackjack.stand(game)
  end
  
end

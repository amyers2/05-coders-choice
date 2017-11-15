defmodule Player.Impl do
  
  @invalid_msg "That's not a valid action, try again..."
  
  
  # === Public API =========================================================== #
  
  def play() do
    play(Blackjack.new_game())
  end
  
  defp play(game) do
    clear_screen()
    get_next_action(Blackjack.table(game))
  end
  
  
  # ~~~ hand-in-progress "handle" action ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp get_next_action({game, table = %{game_state: :in_progress}}) do
    clear_screen()
    print_hands(table)
    get_hit_or_stand_input(game, table)
  end
  
  # the cond used here looks cleaner to me than pattern matching
  # in four separate function heads
  defp get_next_action({game, table = %{game_state: state}}) do
    str = case state do
      :lost -> "Sorry, you LOST."
      :bust -> "Oops, you BUSTED."
      :tie  -> "The hand was a TIE."
      :won  -> "Congrats, you WON!"
    end
    print_hand_result(game, table, "\n" <> str)
  end
  
  
  # ~~~ hand-in-progress "get" action ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp get_hit_or_stand_input(game, table) do
    action = user_prompt("Enter action (hit, stand, exit):")
    in_progress_action(game, table, action)
  end
  
  defp in_progress_action(game, _table, _action = "hit") do
    game = Blackjack.hit(game)
    get_next_action(Blackjack.table(game))
  end
  
  defp in_progress_action(game, _table, _action = "stand") do
    game = Blackjack.stand(game)
    get_next_action(Blackjack.table(game))
  end
  
  defp in_progress_action(_game, _table, _action = "exit") do
    IO.puts "Thanks for playing!"
  end
  
  defp in_progress_action(game, table, _bad_input) do
    IO.puts @invalid_msg
    get_hit_or_stand_input(game, table)
  end
  
  
  # ~~~ hand finished "get" action ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp get_new_game_or_exit(game) do
    action = user_prompt("Enter action (new, exit):")
    hand_finished_action(game, action)
  end
  
  defp hand_finished_action(game, _action = "new") do
    clear_screen()
    play(Blackjack.new_hand(game))
  end
  
  defp hand_finished_action(_game, _action = "exit") do
    IO.puts "Thanks for playing!"
  end
  
  defp hand_finished_action(game, _bad_input) do
    IO.puts @invalid_msg
    get_new_game_or_exit(game)
  end
  
  
  # ~~~ prompts and status ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp user_prompt(str) do
    IO.puts ""
    IO.gets(">> #{str}  ")
      |> String.downcase()
      |> String.trim
  end
  
  defp print_hand_result(game, table, str) do
    clear_screen()
    print_hands(table)
    IO.puts(str)
    print_game_stats(table)
    
    get_new_game_or_exit(game)
  end
  
  defp print_game_stats(table) do
    IO.puts ""
    IO.puts "  Dealer: #{table.dealer_count} | You: #{table.player_count}"
    IO.puts "  Wins: #{table.wins} | Losses: #{table.losses}"
  end
  
  defp print_hands(table) do
    IO.puts ""
    IO.puts "Dealer hand:"
    IO.puts "  #{inspect table.dealer_cards}"
    IO.puts ""
    IO.puts "Your hand:"
    IO.puts "  #{inspect table.player_cards}"
  end
  
  defp clear_screen(), do: IO.write "\e[H\e[2J"
  
end

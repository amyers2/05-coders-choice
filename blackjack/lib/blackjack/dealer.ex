defmodule Blackjack.Dealer do
  
  alias Blackjack.Cards
  alias Blackjack.State
  
  
  # === Public API =========================================================== #

  def new_game() do
    %State{}
      |> Map.put(:deck, new_shuffle_and_burn())
      |> deal_new_hands()
  end
  
  def new_hand(game) do
    game
      |> check_deck(4)
      |> deal_new_hands()
      |> Map.put(:game_state, :in_progress)
  end
  
  def hit(game) do
    game
      |> check_deck(1)
      |> draw_player_card()
      |> count_curr_hands()
      |> evaluate_player_hand()
  end
  
  def stand(game) do
    dealer_turn(game)
  end
  
  def table(game) do
    d_cards = show_dealer_cards(game.dealer_cards, game.game_state)
    {game, table_details(game, d_cards)}
  end
  
  
  # ~~~ table actions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp new_shuffle_and_burn() do
    Deck.shuffle() |> Deck.burn_card()
  end
  
  
  defp check_deck(game, cards_needed) do
    check_deck(game, cards_needed, Enum.count(game.deck))
  end
  
  defp check_deck(game, cards_needed, num_cards)
       when (cards_needed > num_cards) do
    Map.put(game, :deck, Enum.concat(game.deck, new_shuffle_and_burn()))
  end
  
  defp check_deck(game, _cards_needed, _enough_cards), do: game
  
  
  defp deal_new_hands(game = %State{}) do
    {[c1,c2,c3,c4], reduced_deck} = Deck.draw(game.deck, 4)
    
    game
      |> Map.put(:dealer_cards, [c4, c2])
      |> Map.put(:player_cards, [c3, c1])
      |> Map.put(:deck,         reduced_deck)
      |> count_curr_hands()
  end
  
  
  defp table_details(game, d_cards) do
    %{
      game_state:   game.game_state,
      dealer_cards: d_cards,
      dealer_count: game.dealer_count,
      player_cards: Enum.reverse(game.player_cards),
      player_count: game.player_count,
      wins:         game.wins,
      losses:       game.losses
    }
  end
  
  
  # ~~~ player actions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp draw_player_card(game) do
    {[card], reduced_deck} = Deck.draw(game.deck, 1)
    
    game
      |> Map.put(:player_cards, [card | game.player_cards])
      |> Map.put(:deck,         reduced_deck)
  end
  
  
  defp evaluate_player_hand(game) do
    evaluate_player_hand(game, game.player_count)
  end
  
  defp evaluate_player_hand(game, player_count)
       when (player_count > 21) do
    game
      |> Map.put(:game_state, :bust)
      |> Map.put(:losses,     game.losses + 1)
  end
  
  defp evaluate_player_hand(game, _), do: game
  
  
  # ~~~ dealer actions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp show_dealer_cards(dealer_cards, _game_state = :in_progress) do
    [_c1 | t] = Enum.reverse(dealer_cards)
    [{"_", :hidden} | t]
  end
  
  defp show_dealer_cards(dealer_cards, _game_state) do
    Enum.reverse(dealer_cards)
  end
  
  
  defp dealer_turn(game) do
    dealer_turn(game, game.dealer_count, game.player_count)
  end
  
  # dealer is done
  defp dealer_turn(game, d_count, p_count) 
       when (d_count >= 17) and 
            (d_count >= p_count) do
    evaluate_hand_result(game, game.dealer_count, game.player_count)
  end
  
  # dealer not finished
  defp dealer_turn(game, _, _) do
    game
      |> check_deck(1)
      |> draw_dealer_card()
      |> count_curr_hands()
      |> dealer_turn()
  end
  
  
  defp draw_dealer_card(game) do
    {[card], reduced_deck} = Deck.draw(game.deck, 1)
    
    game
      |> Map.put(:dealer_cards, [card | game.dealer_cards])
      |> Map.put(:deck,         reduced_deck)
  end
  
  
  # ~~~ score keeping ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp count_curr_hands(game) do
    game
      |> Map.put(:dealer_count, Cards.count_hand(game.dealer_cards))
      |> Map.put(:player_count, Cards.count_hand(game.player_cards))
  end
  
  
  defp evaluate_hand_result(game, d_count, p_count)
       when (d_count > 21) or 
            (p_count > d_count) do
    game
      |> Map.put(:game_state, :won)
      |> Map.put(:wins,       game.wins + 1)
  end
  
  defp evaluate_hand_result(game, d_count, p_count)
       when (d_count > p_count) do
    game
      |> Map.put(:game_state, :lost)
      |> Map.put(:losses,     game.losses + 1)
  end
  
  defp evaluate_hand_result(game, d_count, p_count)
       when (d_count == p_count) do
    Map.put(game, :game_state, :tie)
  end
  
end

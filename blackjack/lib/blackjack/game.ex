defmodule Blackjack.Game do
  
  alias Blackjack.State
  alias Blackjack.CardValues
  
  
  # === Public API =========================================================== #

  def new_game() do
    %State{}
      |> Map.put(:deck, Deck.shuffle() |> Deck.burn_card())
      |> deal_new_hands()
  end
  
  def new_hand(game) do
    game
      |> deal_new_hands()
      |> Map.put(:game_state, :in_progress)
  end
  
  # deal one card to the player
  def hit(game) do
    game
      |> draw_player_card()
      |> count_curr_hands()
      |> evaluate_player_hand()
  end
  
  # user is done with their hand
  def stand(game) do
    dealer_turn(game)
  end
  
  def get_hands(game) do
    %{
      dealer_cards: game.dealer_cards,
      player_cards: game.player_cards
    }
  end
  
  # === Private API ========================================================== #
  
  defp deal_new_hands(game = %State{}) do
    {d_cards, reduced_deck} = Deck.draw(game.deck, 2);
    {p_cards, reduced_deck} = Deck.draw(reduced_deck, 2);
    
    game
      |> Map.put(:dealer_cards, d_cards)
      |> Map.put(:player_cards, p_cards)
      |> Map.put(:deck,         reduced_deck)
      |> count_curr_hands()
  end
  
  
  # ~~~ Player Actions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp draw_player_card(game) do
    {[card], reduced_deck} = Deck.draw(game.deck, 1)
    
    game
      |> Map.put(:player_cards, [card | game.player_cards])
      |> Map.put(:deck,         reduced_deck)
  end
  
  defp count_curr_hands(game) do
    game
      |> Map.put(:dealer_count, CardValues.count_hand(game.dealer_cards))
      |> Map.put(:player_count, CardValues.count_hand(game.player_cards))
  end
  
  
  defp evaluate_player_hand(game) do
    evaluate_player_hand(game, game.player_count)
  end
  
  defp evaluate_player_hand(game, player_count) when (player_count > 21) do
    game
      |> Map.put(:game_state, :bust)
      |> Map.put(:losses,     game.losses + 1)
  end
  
  defp evaluate_player_hand(game, _), do: game
  
  
  # ~~~ Dealer Logic ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  # todo: eliminate repeat here
  defp draw_dealer_card(game) do
    IO.puts "#{inspect game.dealer_count}"
    {[card], reduced_deck} = Deck.draw(game.deck, 1)
    
    game
      |> Map.put(:dealer_cards, [card | game.dealer_cards])
      |> Map.put(:deck,         reduced_deck)
  end
  
  defp dealer_turn(game) do
    dealer_turn(game, game.dealer_count, game.player_count)
  end
  
  # dealer is done
  defp dealer_turn(game, d_count, p_count) 
       when (d_count >= 17) and (d_count >= p_count) do
    evaluate_hand_result(game, game.dealer_count, game.player_count)
  end
  
  # dealer not finished
  defp dealer_turn(game, _, _) do
    game
      |> draw_dealer_card()
      |> count_curr_hands()
      |> dealer_turn()
  end
  
  
  # ~~~ Hand Evaluation ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp evaluate_hand_result(game, d_count, _) when (d_count > 21) do
    game
      |> Map.put(:game_state, :won) # player wins
      |> Map.put(:wins,       game.wins + 1)
  end
  
  defp evaluate_hand_result(game, d_count, p_count) when (d_count > p_count) do
    game
      |> Map.put(:game_state, :lost)
      |> Map.put(:losses,     game.losses + 1)
  end
  
  defp evaluate_hand_result(game, d_count, p_count) when (p_count > d_count) do
    game
      |> Map.put(:game_state, :won)
      |> Map.put(:wins,       game.wins + 1)
  end
  
  defp evaluate_hand_result(game, d_count, p_count) when (d_count == p_count) do
    Map.put(game, :game_state, :tie)
  end
  
end

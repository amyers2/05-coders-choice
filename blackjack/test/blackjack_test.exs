defmodule BlackjackTest do
  use ExUnit.Case
  doctest Blackjack
  
  alias Blackjack.Dealer

  test "hand values" do
    hand_1 = [{"K", :spaces}, {"A", :clubs}]
    assert 21 == Blackjack.count_hand(hand_1)
    
    hand_2 = [{"K", :spaces}, {"A", :clubs}, {"2", :diamonds}]
    assert 13 == Blackjack.count_hand(hand_2)
    
    hand_3 = [{"7", :hearts}, {"A", :clubs}, {"A", :hearts}, {"A", :diamonds}]
    assert 20 == Blackjack.count_hand(hand_3)
    
    hand_4 = [{"A", :clubs}, {"A", :hearts}, {"A", :diamonds}]
    assert 13 == Blackjack.count_hand(hand_4)
  end
  
  test "new game" do
    game = Dealer.new_game()
    
    %{game_state: :in_progress} = game
    assert 2 == Enum.count(game.dealer_cards)
    assert 2 == Enum.count(game.player_cards)
    assert game.player_count <= 21
    assert game.dealer_count <= 21
  end
  
  test "hit" do
    game = Dealer.new_game()
      |> Dealer.hit()
    assert 3 == Enum.count(game.player_cards)
  end
  
  test "lose" do
    game = Dealer.new_game()
      |> Map.put(:player_cards, [{"2", :spades}, {"2", :clubs}])
      |> Map.put(:player_count, 4)
      |> Map.put(:dealer_cards, [{"K", :clubs}, {"7", :diamonds}])
      |> Map.put(:dealer_count, 17)
      |> Dealer.stand()
    %{game_state: :lost} = game
  end
  
  test "win or tie" do
    game = Dealer.new_game()
      |> Map.put(:player_cards, [{"A", :hearts}, {"K", :diamonds}])
      |> Map.put(:player_count, 21)
      |> Map.put(:dealer_cards, [{"K", :clubs}, {"Q", :diamonds}])
      |> Map.put(:dealer_count, 20)
      |> Dealer.stand()
    %{game_state: state} = game
    
    assert (state == :tie || state == :won)
  end
  
  test "bust" do
    game = Dealer.new_game()
      |> Map.put(:player_cards, [{"J", :hearts}, {"K", :diamonds}])
      |> Map.put(:player_count, 21)
      |> Dealer.hit()
      |> Dealer.hit()
    %{game_state: :bust} = game
  end
  
end

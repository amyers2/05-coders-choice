defmodule BlackjackTest do
  use ExUnit.Case
  doctest Blackjack

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
end

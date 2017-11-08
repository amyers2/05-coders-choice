defmodule Blackjack.Cards do
  
  # ~~~ card value functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp card_value({value, _suit}) when value in ~w(2 3 4 5 6 7 8 9 10) do
    String.to_integer(value)
  end
  
  defp card_value({value, _suit}) when value in ["J", "Q", "K"] do
    10
  end
  
  # ace cards handled below
  
  
  # ~~~ hand counting functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  defp count_hand([], count, _ace_cards = 0) do
    count  # done counting
  end
  
  defp count_hand([], count, ace_cards) 
       when (count + (ace_cards - 1) + 11) <= 21 do
    count_hand([], count + 11, ace_cards - 1)
  end
  
  defp count_hand([], count, ace_cards) do
    count_hand([], count + 1, ace_cards - 1)
  end
  
  defp count_hand([{"A", _suit} | t], count, ace_cards) do
    count_hand(t, count, ace_cards + 1)
  end
  
  defp count_hand([card | t], count, ace_cards) do
    count_hand(t, count + card_value(card), ace_cards)
  end
  
  def count_hand(hand) do
    count_hand(hand, 0, 0)
  end
  
end

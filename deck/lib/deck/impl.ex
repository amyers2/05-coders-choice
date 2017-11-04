defmodule Deck.Impl do

  # === Public API =========================================================== #

  def new_deck() do
    values = ~w(2 3 4 5 6 7 8 9 10 J Q K A)
    suits  = [:spades, :clubs, :hearts, :diamonds]
    create_cards(values, suits)
  end
  
  def shuffle(deck \\ new_deck()) do
    Enum.shuffle(deck)
  end
  
  def cut(deck \\ new_deck(), num_cards) do
    {top, bottom} = Enum.split(deck, num_cards)
    Enum.concat([bottom, top])
  end
  
  def draw(deck, num_cards) do
    {cards, remaining_deck} = Enum.split(deck, num_cards)
  end
  
  def burn_card(deck) do
    {_burned, reduced_deck} = draw(deck, 1);
    reduced_deck
  end

  # === Private API ========================================================== #
  
  defp create_cards(values, suits) do
    join_value_suit(values, suits)
    |> Enum.concat()
  end
  
  defp join_value_suit(_values, []), do: []

  defp join_value_suit(values, [this_suit | rem_suits]) do
    [ Enum.map(values, &{&1, this_suit}) | join_value_suit(values, rem_suits) ]
  end

end
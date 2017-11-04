defmodule Deck do
  
  alias Deck.Impl
  
  defdelegate new_deck(),                         to: Impl
  defdelegate shuffle(deck \\ new_deck()),        to: Impl
  defdelegate cut(deck \\ new_deck(), num_cards), to: Impl
  defdelegate draw(deck, num_cards),              to: Impl
  defdelegate burn_card(deck),                    to: Impl
  
end

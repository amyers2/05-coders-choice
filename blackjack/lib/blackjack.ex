defmodule Blackjack do
  
  alias Blackjack.Game
  alias Blackjack.CardValues
  
  defdelegate new_game(),          to: Game
  defdelegate new_hand(game),      to: Game
  defdelegate hit(game),           to: Game
  defdelegate stand(game),         to: Game
  defdelegate get_hands(game),     to: Game
  defdelegate count_hand(hand),    to: CardValues
  
end

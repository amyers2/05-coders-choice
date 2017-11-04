defmodule Blackjack.State do
  
  defstruct(
    game_state:   :in_progress,
    deck:         [],
    player_cards: [],
    player_count: 0,
    dealer_cards: [],
    dealer_count: 0,
    wins:         0,
    losses:       0,
  )
  
end

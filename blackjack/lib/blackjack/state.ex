defmodule Blackjack.State do
  
  defstruct(
    game_state:   :in_progress,
    dealer_cards: [],
    dealer_count: 0,
    deck:         [],
    losses:       0,
    player_cards: [],
    player_count: 0,
    wins:         0,
  )
  
end

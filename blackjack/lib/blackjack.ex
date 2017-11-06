defmodule Blackjack do
  
  alias Blackjack.Cards
  alias Blackjack.DealerSup
  alias Blackjack.DealerServer
  
  defdelegate new_game(),          to: DealerSup
  defdelegate new_hand(game),      to: DealerServer
  defdelegate hit(game),           to: DealerServer
  defdelegate stand(game),         to: DealerServer
  defdelegate table(game),         to: DealerServer
  defdelegate count_hand(hand),    to: Cards
  
end

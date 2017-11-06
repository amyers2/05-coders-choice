defmodule Blackjack.DealerServer do
  use GenServer
  
  alias Blackjack.Dealer
  
  
  # === Public API =========================================================== #
  
  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end
  
  def new_game(pid) do
    GenServer.call(pid, :new_game)
  end
  
  def new_hand(pid) do
    GenServer.call(pid, :new_hand)
  end
  
  def hit(pid) do
    GenServer.call(pid, :hit)
  end
  
  def stand(pid) do
    GenServer.call(pid, :stand)
  end
  
  def table(pid) do
    GenServer.call(pid, :table)
  end
  
  # === GenServer Implementation ============================================= #
  
  def handle_call(:new_game, _from, _) do
    game = Dealer.new_game()
    {:reply, self(), game}
  end
  
  def handle_call(:new_hand, _from, game) do
    game = Dealer.new_hand(game)
    {:reply, self(), game}
  end
  
  def handle_call(:hit, _from, game) do
    game = Dealer.hit(game)
    {:reply, self(), game}
  end
  
  def handle_call(:stand, _from, game) do
    game = Dealer.stand(game)
    {:reply, self(), game}
  end
  
  def handle_call(:table, _from, game) do
    {game, table} = Dealer.table(game)
    {:reply, {self(), table}, game}
  end
  
end

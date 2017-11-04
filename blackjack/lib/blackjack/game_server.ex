defmodule Blackjack.GameServer do
  use GenServer
  
  alias Blackjack.Game
  @name :game_server
  
  
  # === Public API =========================================================== #
  
  def start_link(_) do
    GenServer.start_link(__MODULE__, name: @name)
  end
  
  def new_game() do
    GenServer.call(@name, :new_game)
  end
  
  def hit(game) do
    GenServer.call(@name, {:hit, game})
  end
  
  def stand(game) do
    GenServer.call(@name, {:stand, game})
  end
  
  # === GenServer Implementation ============================================= #
  
  def handle_call(:new_game, _from, _state) do
    new_state = Game.new_game()
  end
  
  def handle_call({:hit, game}, _from, state) do
  end
  
  def handle_call({:stand, game}, _from, state) do
  end
  
end

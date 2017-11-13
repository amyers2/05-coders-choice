defmodule Blackjack.DealerSup do
  use Supervisor
  
  alias Blackjack.DealerServer
  @name :game_sup
  
  
  # === Supervisor Init ====================================================== #
  
  def start_link() do
    child_spec = 
      Supervisor.child_spec(
        DealerServer, 
        start: {DealerServer, :start_link, []},
        restart: :permanent)
     
    {:ok, _pid} = 
      Supervisor.start_link(
        [child_spec], 
        strategy: :simple_one_for_one,
        name: @name)
  end
  
  def init(_) do
    # not starting any children yet
  end
  
  
  # === Game API ============================================================= #
  
  def new_game() do
    {:ok, pid} = Supervisor.start_child(@name, [])
    DealerServer.new_game(pid)
  end

end

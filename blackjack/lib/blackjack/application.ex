defmodule Blackjack.Application do
  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Blackjack.Worker.start_link(arg)
      {Blackjack.GameServer, []},
    ]
    opts = [strategy: :one_for_one, name: Blackjack.Supervisor]
    
    Supervisor.start_link(children, opts)
  end
  
end

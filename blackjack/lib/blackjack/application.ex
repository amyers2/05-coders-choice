defmodule Blackjack.Application do
  use Application
  
  alias Blackjack.DealerSup
  

  # === Supervisor Init ====================================================== #
  
  def start(_type, _args) do
    DealerSup.start_link()
  end
  
end

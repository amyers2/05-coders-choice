defmodule Player do

  alias Player.Impl

  defdelegate play(),  to: Impl

end

defmodule TwitterWeb.PokemonController do
  use TwitterWeb, :controller
  alias Twitter.PokemonRetriever
  require Logger

  def show(conn, %{"id" => id}) do
    identifier = PokemonRetriever.retrieve(id)

    json(conn, %{identifier: identifier})
  end
end

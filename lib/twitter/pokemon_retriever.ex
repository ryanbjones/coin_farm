defmodule Twitter.PokemonRetriever do
  require Logger

  @pokemon_url "https://pokeapi.co/api/v2/pokemon"

  def find_pokemon(name, returning_attribute) do
    case fetch(name) do
      {:ok, %{status_code: 200} = response} ->
        {:ok, %{^returning_attribute => attr}} = Jason.decode(response.body)
        attr
      {:ok, %{status_code: 404}} ->
        "Not found"
      unknown_response ->
        Logger.error("Unknown reponse from pokemon: #{inspect(unknown_response)}")
    end
  end

  def identifier_to_return(identifier) do
    case Integer.parse(identifier) do
      :error -> :integer
      {_int, ""} -> :name
    end
  end

  def retrieve(identifier) do
    case identifier_to_return(identifier) do
      :name -> find_pokemon(identifier, "name")
      :integer -> find_pokemon(identifier, "id")
    end
  end

  ##
  # Private functions
  #
  defp fetch(identifier) do
    HTTPoison.get("#{@pokemon_url}/#{identifier}")
  end
end

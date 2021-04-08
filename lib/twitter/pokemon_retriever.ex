defmodule Twitter.PokemonRetriever do
  require Logger

  @pokemon_url "https://pokeapi.co/api/v2/pokemon"

  def retrieve(identifier) do
    case Integer.parse(identifier) do
      :error ->
        Logger.info("identifier is a string: #{identifier}")
        find_id_by_name(identifier)
      {identifier, _} ->
        Logger.info("identifier is an integer #{identifier}")
        find_name_by_id(identifier)
    end
  end

  def find_id_by_name(name) do
    parsed_response =
      case fetch(name) do
        {:ok, %{status_code: 200} = response} ->
          {:ok, %{"id" => id}} = Jason.decode(response.body)
          id
        {:ok, %{status_code: 404}} ->
          "Not found"
        unknown_response ->
          Logger.error("Unknown reponse from pokemon: #{inspect(unknown_response)}")
      end
  end

  def find_name_by_id(id) do
    parsed_response =
      case fetch(id) do
        {:ok, %{status_code: 200} = response} ->
          {:ok, %{"name" => name}} = Jason.decode(response.body)
          name
        {:ok, %{status_code: 404}} ->
          "Not found"
        unknown_response ->
          Logger.error("Unknown reponse from pokemon: #{inspect(unknown_response)}")
      end
  end

  defp fetch(identifier) do
    HTTPoison.get("#{@pokemon_url}/#{identifier}")
  end
end

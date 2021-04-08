defmodule Twitter.PokemonRetrieverTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Twitter.PokemonRetriever

  setup_all do
    HTTPoison.start
  end

  describe "#identifier_to_return" do
    test "when given an integer returns :name" do
      assert PokemonRetriever.identifier_to_return("1") == :name
    end

    test "when given a string returns :integer" do
      assert PokemonRetriever.identifier_to_return("bulbosaurus") == :integer
    end
  end

  describe "#retrieve" do
    test "when a valid id is given returns the name" do
      use_cassette "valid_id" do
        assert PokemonRetriever.retrieve("1") == "bulbasaur"
      end
    end

    test "when a valid name is given returns the id" do
      use_cassette "valid_name" do
        assert PokemonRetriever.retrieve("bulbasaur") == 1
      end
    end

    test "when an invalid name is given returns not found" do
      use_cassette "invalid_name" do
        assert PokemonRetriever.retrieve("old mcdonald") == "Not found"
      end
    end

    test "when an invalid id is given returns not found" do
      use_cassette "invalid_id" do
        assert PokemonRetriever.retrieve("31459") == "Not found"
      end
    end
  end
end

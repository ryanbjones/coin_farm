defmodule Twitter.PokemonRetrieverTest do
  use TwitterWeb.ConnCase, async: true

  alias Twitter.PokemonRetriever

  describe "#identifier_to_return" do
    test "when given an integer returns :name" do
      assert PokemonRetriever.identifier_to_return("1") == :name
    end

    test "when given a string returns :integer" do
      assert PokemonRetriever.identifier_to_return("bulbosaurus") == :integer
    end
  end
end

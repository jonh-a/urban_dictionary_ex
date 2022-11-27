defmodule UrbanDictionaryTest do
  use ExUnit.Case
  doctest UrbanDictionary

  test "check random" do
    {:ok, _resp} = UrbanDictionary.random()
    assert :ok == :ok
  end

  test "define elixir" do
    {:ok, _resp} = UrbanDictionary.define("elixir")
    assert :ok == :ok
  end

  test "define exact elixir" do
    {:ok, _resp} = UrbanDictionary.define_exact("elixir")
    assert :ok == :ok
  end
end

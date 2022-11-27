defmodule UrbanDictionaryTest do
  use ExUnit.Case
  doctest UrbanDictionary

  test "check random" do
    {:ok, _resp} = UrbanDictionary.random()
    assert :ok == :ok
  end

  test "check word of the day" do
    {:ok, _resp} = UrbanDictionary.words_of_the_day()
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

  test "define elixir by defid" do
    {:ok, _resp} = UrbanDictionary.define_by_defid("1454963")
    assert :ok == :ok
  end
end

defmodule UrbanDictionary do
  @moduledoc """
  Documentation for `UrbanDictionary`.
  """
  use HTTPoison.Base

  def process_response_body(body) do
    JSX.decode!(body)
  end

  defp get_base_url do
    "https://api.urbandictionary.com/v0/"
  end

  def random do
    case UrbanDictionary.get("#{get_base_url()}random") do
      {:ok, resp} ->
        {:ok, resp}

      {:error, _error} ->
        :error
    end
  end

  def define(term) do
    case UrbanDictionary.get("#{get_base_url()}define?term=#{URI.encode(term)}") do
      {:ok, resp} ->
        {:ok, get_in(resp.body, ["list"])}

      {:error, _error} ->
        :error
    end
  end

  def define_exact(term) do
    case UrbanDictionary.get("#{get_base_url()}define?term=#{URI.encode(term)}") do
      {:ok, resp} ->
        {:ok,
         get_in(resp.body, ["list"])
         |> Enum.filter(fn x -> String.downcase(get_in(x, ["word"])) == String.downcase(term) end)}

      {:error, _error} ->
        :error
    end
  end
end

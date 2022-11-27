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

  defp get_list(body) do
    get_in(body, ["list"])
  end

  defp parse_response(resp) do
    case resp do
      {:ok, resp} ->
        list = get_list(resp.body)

        if length(list) > 0 do
          {:ok, list}
        else
          {:error, "No results were found."}
        end

      {:error, _error} ->
        {:error, "Request failed."}
    end
  end

  def random do
    UrbanDictionary.get("#{get_base_url()}random")
    |> parse_response()
  end

  def words_of_the_day do
    UrbanDictionary.get("#{get_base_url()}words_of_the_day")
    |> parse_response()
  end

  def define(term) do
    UrbanDictionary.get("#{get_base_url()}define?term=#{URI.encode(term)}")
    |> parse_response()
  end

  def define_by_defid(defid) do
    UrbanDictionary.get("#{get_base_url()}define?defid=#{URI.encode(defid)}")
    |> parse_response()
  end

  def define_exact(term) do
    case UrbanDictionary.get("#{get_base_url()}define?term=#{URI.encode(term)}")
         |> parse_response() do
      {:ok, resp} ->
        exact_matches =
          Enum.filter(resp, fn x ->
            String.downcase(get_in(x, ["word"])) == String.downcase(term)
          end)

        if length(exact_matches) > 0 do
          {:ok, exact_matches}
        else
          {:error, "No exact matches were found."}
        end

      {:error, error} ->
        {:error, error}
    end
  end
end

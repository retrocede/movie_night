defmodule MovieNightWeb.SearchEndpointController do
    use MovieNightWeb, :controller

    # there is probably a better way to do this, but this will work for the moment
    def index(conn, %{ "query" => query, "page" => page}) do
        api_key = System.get_env "TMDB_KEY"
        case HTTPoison.get "https://api.themoviedb.org/3/search/movie?api_key=#{ api_key }&query=#{ query }&page=#{ page }" do
            {:ok, %HTTPoison.Response{ status_code: 200, body: body }} ->
                {:ok, %{"results" => results, "total_pages" => pages, "page" => page }} = Poison.Parser.parse body
                json conn, %{ "results" => results, "pages" => pages, "page" => page }
            {:ok, %HTTPoison.Response{ status_code: 404 }} ->
                json conn, %{ error: "not found" }
            {:error, %HTTPoison.Error{ reason: reason }} ->
                json conn, %{ error: reason }
        end
    end

    def index(conn, %{ "query" => query }) do
        api_key = System.get_env "TMDB_KEY"
        case HTTPoison.get "https://api.themoviedb.org/3/search/movie?api_key=#{ api_key }&query=#{ query }" do
            {:ok, %HTTPoison.Response{ status_code: 200, body: body }} ->
                {:ok, %{"results" => results, "total_pages" => pages, "page" => page }} = Poison.Parser.parse body
                json conn, %{ "results" => results, "pages" => pages, "page" => page }
            {:ok, %HTTPoison.Response{ status_code: 404 }} ->
                json conn, %{ error: "not found" }
            {:error, %HTTPoison.Error{ reason: reason }} ->
                json conn, %{ error: reason }
        end
    end

    def index(conn, _params) do
        conn
        |> put_status(400)
        |> text("a search value in parameter query is needed")
    end
end
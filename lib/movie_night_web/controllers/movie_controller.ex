defmodule MovieNightWeb.MovieController do
  use MovieNightWeb, :controller

  alias MovieNight.Movies
  alias MovieNight.Movies.Movie

  action_fallback MovieNightWeb.FallbackController

  def index(conn, _params) do
    movies = Movies.list_movies()
    render(conn, "index.json", movies: movies)
  end

  def create(conn, %{ "id" => api_id }) do
    api_key = System.get_env "TMDB_KEY"
    case HTTPoison.get "https://api.themoviedb.org/3/movie/#{ api_id }?api_key=#{ api_key }&append_to_response=videos" do
      {:ok, %HTTPoison.Response{ status_code: 200, body: body }} ->
          {:ok, api_response} = Poison.Parser.parse body
          derived_struct = derive_properties api_response
          movie = Map.merge derived_struct, %{"api_id" => api_id }
          IO.inspect movie
          save conn, movie
      {:ok, %HTTPoison.Response{ status_code: 404 }} ->
          json conn, %{ error: "not found" }
      {:error, %HTTPoison.Error{ reason: reason }} ->
          json conn, %{ error: reason }
    end
  end

  defp derive_properties(api_response) do
    %{ "backdrop_path" => backdrop_path, "poster_path" => poster_path } = api_response
    %{ "videos" => %{"results" => videos }} = api_response
    [ %{ "key" => trailer } | _ ] = Enum.sort(Enum.filter(videos, fn(video) -> video["type"] == "Trailer" and video["site"] == "YouTube" end), &(&1["size"] >= &2["size"]))
    new_vals = %{ "backdrop" => "https://image.tmdb.org/t/p/w500#{ backdrop_path }", "poster" => "https://image.tmdb.org/t/p/w500#{ poster_path }", "trailer" => "https://www.youtube.com/watch?v=#{ trailer }" }
    Map.merge api_response, new_vals
  end

  defp save(conn, movie_params) do
    with {:ok, %Movie{} = movie} <- Movies.create_movie(movie_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.movie_path(conn, :show, movie))
      |> render("show.json", movie: movie)
    end
  end

  def show(conn, %{"id" => id}) do
    movie = Movies.get_movie!(id)
    render(conn, "show.json", movie: movie)
  end

  def update(conn, %{"id" => id, "movie" => movie_params}) do
    movie = Movies.get_movie!(id)

    with {:ok, %Movie{} = movie} <- Movies.update_movie(movie, movie_params) do
      render(conn, "show.json", movie: movie)
    end
  end

  def delete(conn, %{"id" => id}) do
    movie = Movies.get_movie!(id)
    with {:ok, %Movie{}} <- Movies.delete_movie(movie) do
      send_resp(conn, :no_content, "")
    end
  end
end

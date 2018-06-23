defmodule MovieNightWeb.MovieView do
  use MovieNightWeb, :view
  alias MovieNightWeb.MovieView

  def render("index.json", %{movies: movies}) do
    %{data: render_many(movies, MovieView, "movie.json")}
  end

  def render("show.json", %{movie: movie}) do
    %{data: render_one(movie, MovieView, "movie.json")}
  end

  def render("movie.json", %{movie: movie}) do
    %{id: movie.id,
      backdrop: movie.backdrop,
      homepage: movie.homepage,
      api_id: movie.api_id,
      imdb_id: movie.imdb_id,
      overview: movie.overview,
      poster: movie.poster,
      runtime: movie.runtime,
      tagline: movie.tagline,
      title: movie.title,
      trailer: movie.trailer,
      status: movie.status}
  end
end

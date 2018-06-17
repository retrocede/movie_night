defmodule MovieNight.MoviesTest do
  use MovieNight.DataCase

  alias MovieNight.Movies

  describe "movies" do
    alias MovieNight.Movies.Movie

    @valid_attrs %{api_id: 42, backdrop: "some backdrop", homepage: "some homepage", imdb_id: "some imdb_id", overview: "some overview", poster: "some poster", runtime: 42, tagline: "some tagline", title: "some title", trailer: "some trailer"}
    @update_attrs %{api_id: 43, backdrop: "some updated backdrop", homepage: "some updated homepage", imdb_id: "some updated imdb_id", overview: "some updated overview", poster: "some updated poster", runtime: 43, tagline: "some updated tagline", title: "some updated title", trailer: "some updated trailer"}
    @invalid_attrs %{api_id: nil, backdrop: nil, homepage: nil, imdb_id: nil, overview: nil, poster: nil, runtime: nil, tagline: nil, title: nil, trailer: nil}

    def movie_fixture(attrs \\ %{}) do
      {:ok, movie} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Movies.create_movie()

      movie
    end

    test "list_movies/0 returns all movies" do
      movie = movie_fixture()
      assert Movies.list_movies() == [movie]
    end

    test "get_movie!/1 returns the movie with given id" do
      movie = movie_fixture()
      assert Movies.get_movie!(movie.id) == movie
    end

    test "create_movie/1 with valid data creates a movie" do
      assert {:ok, %Movie{} = movie} = Movies.create_movie(@valid_attrs)
      assert movie.api_id == 42
      assert movie.backdrop == "some backdrop"
      assert movie.homepage == "some homepage"
      assert movie.imdb_id == "some imdb_id"
      assert movie.overview == "some overview"
      assert movie.poster == "some poster"
      assert movie.runtime == 42
      assert movie.tagline == "some tagline"
      assert movie.title == "some title"
      assert movie.trailer == "some trailer"
    end

    test "create_movie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_movie(@invalid_attrs)
    end

    test "update_movie/2 with valid data updates the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{} = movie} = Movies.update_movie(movie, @update_attrs)
      
      assert movie.api_id == 43
      assert movie.backdrop == "some updated backdrop"
      assert movie.homepage == "some updated homepage"
      assert movie.imdb_id == "some updated imdb_id"
      assert movie.overview == "some updated overview"
      assert movie.poster == "some updated poster"
      assert movie.runtime == 43
      assert movie.tagline == "some updated tagline"
      assert movie.title == "some updated title"
      assert movie.trailer == "some updated trailer"
    end

    test "update_movie/2 with invalid data returns error changeset" do
      movie = movie_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_movie(movie, @invalid_attrs)
      assert movie == Movies.get_movie!(movie.id)
    end

    test "delete_movie/1 deletes the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{}} = Movies.delete_movie(movie)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_movie!(movie.id) end
    end

    test "change_movie/1 returns a movie changeset" do
      movie = movie_fixture()
      assert %Ecto.Changeset{} = Movies.change_movie(movie)
    end
  end
end

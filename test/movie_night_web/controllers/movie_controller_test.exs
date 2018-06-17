defmodule MovieNightWeb.MovieControllerTest do
  use MovieNightWeb.ConnCase

  alias MovieNight.Movies
  alias MovieNight.Movies.Movie

  @create_attrs %{api_id: 42, backdrop: "some backdrop", homepage: "some homepage", imdb_id: "some imdb_id", overview: "some overview", poster: "some poster", runtime: 42, tagline: "some tagline", title: "some title", trailer: "some trailer"}
  @update_attrs %{api_id: 43, backdrop: "some updated backdrop", homepage: "some updated homepage", imdb_id: "some updated imdb_id", overview: "some updated overview", poster: "some updated poster", runtime: 43, tagline: "some updated tagline", title: "some updated title", trailer: "some updated trailer"}
  @invalid_attrs %{api_id: nil, backdrop: nil, homepage: nil, imdb_id: nil, overview: nil, poster: nil, runtime: nil, tagline: nil, title: nil, trailer: nil}

  def fixture(:movie) do
    {:ok, movie} = Movies.create_movie(@create_attrs)
    movie
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all movies", %{conn: conn} do
      conn = get conn, Routes.movie_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create movie" do
    test "renders movie when data is valid", %{conn: conn} do
      conn = post conn, Routes.movie_path(conn, :create), movie: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, Routes.movie_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "api_id" => 42,
        "backdrop" => "some backdrop",
        "homepage" => "some homepage",
        "imdb_id" => "some imdb_id",
        "overview" => "some overview",
        "poster" => "some poster",
        "runtime" => 42,
        "tagline" => "some tagline",
        "title" => "some title",
        "trailer" => "some trailer"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.movie_path(conn, :create), movie: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update movie" do
    setup [:create_movie]

    test "renders movie when data is valid", %{conn: conn, movie: %Movie{id: id} = movie} do
      conn = put conn, Routes.movie_path(conn, :update, movie), movie: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, Routes.movie_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "api_id" => 43,
        "backdrop" => "some updated backdrop",
        "homepage" => "some updated homepage",
        "imdb_id" => "some updated imdb_id",
        "overview" => "some updated overview",
        "poster" => "some updated poster",
        "runtime" => 43,
        "tagline" => "some updated tagline",
        "title" => "some updated title",
        "trailer" => "some updated trailer"}
    end

    test "renders errors when data is invalid", %{conn: conn, movie: movie} do
      conn = put conn, Routes.movie_path(conn, :update, movie), movie: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete movie" do
    setup [:create_movie]

    test "deletes chosen movie", %{conn: conn, movie: movie} do
      conn = delete conn, Routes.movie_path(conn, :delete, movie)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, Routes.movie_path(conn, :show, movie)
      end
    end
  end

  defp create_movie(_) do
    movie = fixture(:movie)
    {:ok, movie: movie}
  end
end

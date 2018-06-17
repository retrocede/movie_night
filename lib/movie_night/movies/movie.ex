defmodule MovieNight.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset


  schema "movies" do
    field :api_id, :integer
    field :backdrop, :string, default: ""
    field :homepage, :string, default: ""
    field :imdb_id, :string, default: ""
    field :overview, :string, default: ""
    field :poster, :string, default: ""
    field :runtime, :integer, default: 0
    field :tagline, :string, default: ""
    field :title, :string, default: ""
    field :trailer, :string, default: ""

    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:backdrop, :homepage, :api_id, :imdb_id, :overview, :poster, :runtime, :tagline, :title, :trailer])
    |> validate_required([:api_id, :overview, :title ])
  end
end

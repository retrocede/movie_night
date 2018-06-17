defmodule MovieNight.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :backdrop, :string
      add :homepage, :string
      add :api_id, :integer
      add :imdb_id, :string
      add :overview, :string
      add :poster, :string
      add :runtime, :integer
      add :tagline, :string
      add :title, :string
      add :trailer, :string

      timestamps()
    end

  end
end

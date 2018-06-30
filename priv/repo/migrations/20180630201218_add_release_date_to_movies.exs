defmodule MovieNight.Repo.Migrations.AddReleaseDateToMovies do
  use Ecto.Migration

  def change do
    alter table(:movies) do
      add :release_date, :text
    end
  end
end

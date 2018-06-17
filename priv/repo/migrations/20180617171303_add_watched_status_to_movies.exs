defmodule MovieNight.Repo.Migrations.AddWatchedStatusToMovies do
  use Ecto.Migration

  def change do
    alter table(:movies) do
      add :status, :string
    end
  end
end

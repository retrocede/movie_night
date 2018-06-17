defmodule MovieNight.Repo.Migrations.UpdateStringsToTextToAllowLongerContent do
  use Ecto.Migration

  def change do
    alter table(:movies) do
      modify :backdrop, :text
      modify :homepage, :text
      modify :imdb_id, :text
      modify :overview, :text
      modify :poster, :text
      modify :tagline, :text
      modify :title, :text
      modify :trailer, :text
      modify :status, :text
    end
  end
end

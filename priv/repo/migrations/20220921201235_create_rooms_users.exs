defmodule Notalone.Repo.Migrations.CreateRoomsUsers do
  use Ecto.Migration

  def change do
    create table(:rooms_users) do
      add :user_id, :integer
      add :room_id, :integer

      timestamps()
    end
  end
end

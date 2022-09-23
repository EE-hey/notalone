defmodule Notalone.Repo.Migrations.UniqueConstraintOnRoom2 do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE rooms add constraint unique_room_name unique(room_name)", ""

  end
end

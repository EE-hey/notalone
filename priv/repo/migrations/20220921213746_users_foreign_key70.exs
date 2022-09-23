defmodule Notalone.Repo.Migrations.UsersForeignKey70 do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE rooms_users add constraint fkey2 foreign key(room_id) references rooms(id)", ""

  end
end

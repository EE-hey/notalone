defmodule Notalone.Repo.Migrations.UsersForeignKey57 do
  use Ecto.Migration

  def change do
    execute "ALTER TABLE rooms_users add constraint fkey foreign key(user_id) references users(id)", ""
  end
end

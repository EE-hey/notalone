defmodule Notalone.Room_user do
  use Ecto.Schema
  import Ecto.Changeset
  schema "rooms_users" do
    field :room_id, :integer
    field :user_id, :integer
    belongs_to :users, Notalone.Accounts.User
    has_many :rooms, Notalone.Room
    timestamps()
  end

  @doc false
  def changeset(room_user, attrs) do
    room_user
    |> cast(attrs, [:user_id, :room_id])
    |> validate_required([:user_id, :room_id])
  end
end

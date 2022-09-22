defmodule Notalone.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :room_name, :string

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:room_name])
    |> validate_required([:room_name])
  end
end

defmodule NotaloneWeb.PageController do
  import Ecto.Query
  use NotaloneWeb, :controller
  alias Notalone.{Repo,Room}

  def index(conn, _params) do
    render(conn, "index.html")
  end
  def create_room(conn, params) do
    if Map.has_key?(params, "room_name") && ! Repo.get_by(Room, room_name: params["room_name"]) do
       Repo.insert(%Room{room_name: params["room_name"] })
    end
    room_list = Repo.all(from r in Room, select: r.room_name)
    render(conn, "create_room.html", room_list: room_list)
  end

  def current_room(conn, params) do
    render(conn, "current_room.html", room: params["room_name"])
  end
end

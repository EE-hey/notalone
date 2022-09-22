defmodule NotaloneWeb.PageController do
  import Ecto.Query
  use NotaloneWeb, :controller
  alias Notalone.{Repo,Room}

  def index(conn, _params) do
    render(conn, "index.html")
  end
  def create_room(conn, params) do
    if Map.has_key?(params, "room_name") do
       Repo.insert(%Room{room_name: params["room_name"] })
    end

    query = from r in Room, select: r.room_name
    room_list = Repo.all(query)

    render(conn, "create_room.html", room_list: room_list)
  end

  def current_room(conn, params) do
    IO.inspect( params)
    render(conn, "current_room.html", room: params["room_name"])
  end
end

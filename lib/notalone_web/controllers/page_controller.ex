defmodule NotaloneWeb.PageController do
  import Ecto.Query
  use NotaloneWeb, :controller
  alias Notalone.{Repo,Room,Accounts.User,Room_user}

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

  def join_new_room(conn, _params) do
    render(conn, "join_new_room.html")
  end


  def register_room(conn, %{"join_room" => join_room} = _params) do
     case Repo.get_by(Room, room_name: join_room) do
       nil -> conn |> redirect(to: "/join-new-room")
       _ ->
        room_id = Repo.get_by(Room, room_name: join_room).id
        Repo.insert(%Room_user{user_id: conn.assigns[:current_user].id, room_id: room_id })
        conn |> redirect(to: "/room/#{join_room}")
     end


  end


  def user_has_access_to_room(conn, _params) do
    room_id = Repo.get_by(Room, room_name: conn.params["room_name"]).id
    user_id = conn.assigns[:current_user].id
    IO.inspect(room_id)
    query = from r in Room_user, where: r.room_id == ^room_id and r.user_id == ^user_id, select: r.room_id
    case Repo.all(query) do
      [_] -> conn
      _ -> conn |> redirect(to: "/")
    end
  end

end

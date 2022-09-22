defmodule NotaloneWeb.CurrentRoom do
  use NotaloneWeb, :live_view
  alias Notalone.{Repo,Room}
  def mount(params, _session, socket) do

    case Repo.get_by(Room, room_name: params["room_name"]) do
      nil ->
        NotaloneWeb.Endpoint.subscribe("General")
        {:ok, assign(socket, :values , %{room: "General", message: []})}

      _ ->
        NotaloneWeb.Endpoint.subscribe(params["room_name"])
        {:ok, assign(socket, :values , %{room: params["room_name"], message: []})}
    end

  end


  def handle_info(%{event: "msg", payload: %{values: %{message: message, room: room}}}, socket ) do
    {:noreply, assign(socket, :values, %{room: room, message: message})}
  end

  def handle_event("envoyer", %{"text" => text}, socket) do
    NotaloneWeb.Endpoint.broadcast(socket.assigns.values[:room], "msg", %{values: %{ room: socket.assigns.values[:room], message: socket.assigns.values[:message] ++ [text]}} )
    {:noreply, assign(socket, %{ room: socket.assigns.values[:room], message: socket.assigns.values[:message] ++ [text]})}
    #{:noreply, socket}
  end

  def render(assigns) do
    Phoenix.View.render(NotaloneWeb.PageView, "current_room.html", assigns)
  end
end

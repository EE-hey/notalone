defmodule NotaloneWeb.CurrentRoom do
  use NotaloneWeb, :live_view
  alias Notalone.{Repo,Room}
  def mount(params, _session, socket) do

    case Repo.get_by(Room, room_name: params["room_name"]) do
      nil ->
        {:ok, socket}
      _ ->
        NotaloneWeb.Endpoint.subscribe(params["room_name"])
        {:ok, assign(socket, :values , %{room: params["room_name"], message: []})}
    end
  end

  def handle_params(params, _uri, socket) do
    case Repo.get_by(Room, room_name: params["room_name"]) do
      nil ->
        {:noreply, push_patch(socket, to:  "/" )}
      _ ->
        {:noreply, socket}
    end
  end
  def handle_info(%{event: "msg", payload: %{values: %{message: message, room: room}}}, socket ) do
    {:noreply, assign(socket, :values, %{room: room, message: message})}
  end

  def handle_event("envoyer", %{"text" => text}, socket) do
    terminal_prompt()
    NotaloneWeb.Endpoint.broadcast(socket.assigns.values[:room], "msg", %{values: %{ room: socket.assigns.values[:room], message: socket.assigns.values[:message] ++ [text]}} )
    {:noreply, assign(socket, %{ room: socket.assigns.values[:room], message: socket.assigns.values[:message] ++ [text]})}
  end

  def render(assigns) do
    Phoenix.View.render(NotaloneWeb.PageView, "current_room.html", assigns)
  end

  defp terminal_prompt() do
    IO.puts "This is currently on the terminal"
  end
end

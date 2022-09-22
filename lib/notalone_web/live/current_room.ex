defmodule NotaloneWeb.CurrentRoom do
  use NotaloneWeb, :live_view
  def mount(params, _session, socket) do
    NotaloneWeb.Endpoint.subscribe(params["room_name"])
    {:ok, assign(socket, :values , %{room: params["room_name"], message: []})}
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

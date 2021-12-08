defmodule PhoenixPathWeb.RoomChannelTest do
  use PhoenixPathWeb.ChannelCase

  @moduletag :room_channel

  setup do
    {:ok, _, socket} =
      PhoenixPathWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(PhoenixPathWeb.RoomChannel, "room:lobby")

    %{socket: socket}
  end

  test "shout broadcasts to room:lobby", %{socket: socket} do
    push(socket, "new_msg", %{"body" => "all"})
    assert_broadcast "new_msg", %{body: "all"}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "broadcast", %{"some" => "data"})
    assert_push "broadcast", %{"some" => "data"}
  end
end

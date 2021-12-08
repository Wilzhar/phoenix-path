defmodule PhoenixPath.ShoppingCartFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixPath.ShoppingCart` context.
  """

  @doc """
  Generate a unique cart user_uuid.
  """
  def unique_cart_user_uuid do
    Ecto.UUID.generate()
  end

  @doc """
  Generate a cart.
  """
  def cart_fixture(attrs \\ %{}) do
    {:ok, cart} =
      attrs
      |> Enum.into(%{
        user_uuid: unique_cart_user_uuid()
      })
      |> PhoenixPath.ShoppingCart.create_cart()

    cart
  end

  @doc """
  Generate a cart_item.
  """
  def cart_item_fixture(attrs \\ %{}) do
    {:ok, cart_item} =
      attrs
      |> Enum.into(%{
        price_when_carted: "120.500000",
        quantity: 42
      })
      |> PhoenixPath.ShoppingCart.create_cart_item()

    cart_item
  end
end

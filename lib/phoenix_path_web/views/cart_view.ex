defmodule PhoenixPathWeb.CartView do
  use PhoenixPathWeb, :view

  alias PhoenixPath.ShoppingCart

  def currency_to_str(%Decimal{} = val), do: "$#{Decimal.round(val, 2)}"
end

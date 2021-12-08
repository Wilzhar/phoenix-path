defmodule PhoenixPathWeb.ErrorViewTest do
  use PhoenixPathWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  @moduletag :error_view_case

  @tag error_view_test_case: "404"
  test "renders 404.html" do
    assert render_to_string(PhoenixPathWeb.ErrorView, "404.html", []) ==
             "<div> \n  <h1> 404 not found</h1>\n</div>\n"
  end

  @tag error_view_test_case: "500"
  test "renders 500.html" do
    assert render_to_string(PhoenixPathWeb.ErrorView, "500.html", []) == "Internal Server Error"
  end
end

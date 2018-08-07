defmodule AlumniBook.PageControllerTest do
  use AlumniBookWeb.ConnCase

  test "GET /" do
    conn = get(build_conn(), "/")
    assert html_response(conn, 200) =~ "Sign in with GitHub"
    assert html_response(conn, 200) =~ "Sign in with Facebook"
  end
end

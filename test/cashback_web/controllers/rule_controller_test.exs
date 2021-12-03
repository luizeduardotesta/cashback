defmodule CashbackWeb.RuleControllerTest do
  use CashbackWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create/2" do
    test "returns a rule when valid data", %{conn: conn} do
      params = %{description: "cashback simples", bonus: 10}

      conn = post(conn, Routes.rule_path(conn, :create), rule: params)

      assert subject = json_response(conn, 201)["data"]
      assert subject["description"] == params.description
      assert subject["bonus"] == params.bonus
      assert is_nil(subject["id"]) == false
    end

    test "returns error when invalid data", %{conn: conn} do
      params = %{description: "", bonus: 10}

      conn = post(conn, Routes.rule_path(conn, :create), rule: params)

      assert subject = json_response(conn, 422)
    end
  end
end

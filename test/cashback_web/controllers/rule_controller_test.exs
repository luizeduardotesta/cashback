defmodule CashbackWeb.RuleControllerTest do
  use CashbackWeb.ConnCase

  import Cashback.RulesFixtures

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

      assert _subject = json_response(conn, 422)
    end
  end

  describe "index/2" do
    setup %{conn: conn} do
      {:ok, conn: conn, rule: rule_fixture()}
    end

    test "returns a list of rules when valid data", %{conn: conn, rule: rule} do
      conn = get(conn, Routes.rule_path(conn, :index))

      assert [subject] = json_response(conn, 200)["data"]
      assert subject["id"] == rule.id
      assert subject["description"] == rule.description
      assert subject["bonus"] == rule.bonus
    end
  end
end

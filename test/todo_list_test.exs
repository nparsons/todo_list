defmodule TodoListTest do
  use ExUnit.Case
  doctest TodoList

  test "creates a new to-do list" do
    empty_list = TodoList.new()
    assert [] == TodoList.entries(empty_list, ~D[2020-12-09])
  end

  test "adds entry for non-existant date" do
    expected_title = "Dentist"
    expected_date = ~D[2020-12-09]

    test_list =
      TodoList.new()
      |> TodoList.add_entry(
        expected_date,
        expected_title
      )

    actual_title = hd(TodoList.entries(test_list, expected_date))
    assert expected_title == actual_title
  end

  test "adds entry for existing date" do
    expected_title = "Dentist"
    expected_date = ~D[2020-12-09]

    test_list =
      TodoList.new()
      |> TodoList.add_entry(
        expected_date,
        "Eat breakfast"
      )
      |> TodoList.add_entry(
        expected_date,
        expected_title
      )

    actual_title =
      TodoList.entries(test_list, expected_date)
      |> Enum.filter(&(&1 == "Dentist"))
      |> hd()

    assert expected_title == actual_title
  end
end

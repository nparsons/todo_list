defmodule TodoListTest do
  use ExUnit.Case
  doctest TodoList

  test "creates a new to-do list" do
    assert TodoList.new() == %{}
  end

  test "adds entry for non-existant date" do
    expected_title = "Dentist"
    expected_date = ~D[2020-12-09]
    test_list = TodoList.new()
    assert Enum.count(test_list) == 0

    test_list =
      TodoList.add_entry(
        test_list,
        expected_date,
        expected_title
      )

    assert Enum.count(test_list) > 0
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

    assert Enum.count(test_list) > 0

    test_list =
      TodoList.add_entry(
        test_list,
        expected_date,
        expected_title
      )

    assert Enum.count(TodoList.entries(test_list, expected_date)) == 2

    actual_title =
      TodoList.entries(test_list, expected_date)
      |> Enum.filter(&(&1 == "Dentist"))
      |> hd()

    assert expected_title == actual_title
  end
end

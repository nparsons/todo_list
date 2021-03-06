defmodule TodoListTest do
  use ExUnit.Case
  doctest TodoList

  test "creates a new empty to-do list" do
    expected_entries = 0
    empty_list = TodoList.new()

    assert expected_entries == Enum.count(empty_list.entries)
  end

  test "creates a new to-do list with entries" do
    test_entries = [
      %{date: ~D[2020-12-10], title: "Dentist"},
      %{date: ~D[2020-12-10], title: "Shopping"},
      %{date: ~D[2020-12-10], title: "Movies"}
    ]

    test_list = TodoList.new(test_entries)
    entries = TodoList.entries(test_list, ~D[2020-12-10])
    assert test_entries == Enum.map(entries, &Map.delete(&1, :id))
  end

  test "adds entry for non-existant date" do
    expected_title = "Dentist"
    expected_date = ~D[2020-12-09]

    test_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: expected_date, title: expected_title})

    actual_entry = hd(TodoList.entries(test_list, expected_date))
    assert expected_title == actual_entry.title
  end

  test "adds entry for existing date" do
    expected_title = "Dentist"
    expected_date = ~D[2020-12-09]

    test_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: expected_date, title: "Eat breakfast"})
      |> TodoList.add_entry(%{date: expected_date, title: expected_title})

    actual_entry =
      TodoList.entries(test_list, expected_date)
      |> Enum.filter(&(&1.title == "Dentist"))
      |> hd()

    assert expected_title == actual_entry.title
  end

  test "updates entry with non-existance id" do
    test_list = TodoList.new()
    assert test_list == TodoList.update_entry(test_list, -44, &(&1 + 1))
  end

  test "updates entry title with existing id" do
    expected_title = "Dentist"
    original_title = "Get Dressed"
    test_date = ~D[2020-12-10]

    test_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: test_date, title: original_title})

    test_list = TodoList.update_entry(test_list, 1, &Map.put(&1, :title, expected_title))

    updated_entry =
      TodoList.entries(test_list, test_date)
      |> Enum.filter(&(&1.title == expected_title))
      |> hd()

    assert expected_title == updated_entry.title

    original_title_count =
      TodoList.entries(test_list, test_date)
      |> Enum.filter(&(&1.title == original_title))
      |> Enum.count()

    assert 0 == original_title_count
  end

  test "deletes entry with non-existing id" do
    test_list = TodoList.new()
    test_entries = test_list.entries
    test_list = TodoList.delete_entry(test_list, -44)
    assert test_list.entries == test_entries
  end

  test "deletes entity with existing id" do
    test_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: ~D[2020-12-10], title: "Dentist"})

    test_entries = test_list.entries
    test_list = TodoList.delete_entry(test_list, 1)
    assert test_entries != test_list.entries
  end
end

defmodule CsvImporterTest do
  use ExUnit.Case
  doctest TodoList

  test "creates todo list from contents in CSV file" do
    expected_entry_count = 3
    todo_list = TodoList.CsvImporter.import("/home/nparsons/data/todos.csv")

    assert expected_entry_count == Enum.count(todo_list.entries)
  end
end

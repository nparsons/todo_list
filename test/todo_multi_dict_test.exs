defmodule TodoMultiDictTest do
  use ExUnit.Case
  doctest MultiDict

  test "creates a new multi dict structure" do
    assert MultiDict.new() == %{}
  end

  test "adds new value for non-existing key" do
    test_dict = MultiDict.new()
    assert Enum.count(test_dict) == 0

    test_dict =
      MultiDict.add(
        test_dict,
        :expected_key,
        :expected_value
      )

    assert Enum.count(test_dict) > 0
    actual_value = hd(MultiDict.get(test_dict, :expected_key))
    assert :expected_value == actual_value
  end

  test "adds new value for existing key" do
    test_dict =
      MultiDict.new()
      |> MultiDict.add(
        :expected_key,
        "Eat breakfast"
      )

    assert Enum.count(test_dict) > 0

    test_dict =
      MultiDict.add(
        test_dict,
        :expected_key,
        :expected_value
      )

    assert Enum.count(MultiDict.get(test_dict, :expected_key)) == 2

    actual_value =
      MultiDict.get(test_dict, :expected_key)
      |> Enum.filter(&(&1 == :expected_value))
      |> hd()

    assert :expected_value == actual_value
  end
end

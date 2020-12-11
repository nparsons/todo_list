defmodule TodoList.CsvImporter do
  def import(filename) do
    params =
      filename
      |> File.stream!()
      |> Stream.map(fn line -> String.replace(line, "\n", "") end)
      |> Stream.map(fn line ->
        [dtm, title] = String.split(line, ",")
        [year, month, day] = String.split(dtm, "/")
        year = String.to_integer(year)
        month = String.to_integer(month)
        day = String.to_integer(day)
        {:ok, dtm} = Date.new(year, month, day)
        %{date: dtm, title: title}
      end)
      |> Enum.to_list()

    TodoList.new(params)
  end
end

defmodule DesafioBackend.Util do

  def date_br_to_datetime(data) do

    [day, month, year] =  data |> String.split("/")

    day_to_time = day |> String.to_integer
    month_to_time = month |> String.to_integer
    year_to_time = year |> String.to_integer

    {{year_to_time, month_to_time, day_to_time}, {00, 00, 00}} |> NaiveDateTime.from_erl!() |> DateTime.from_naive!("Etc/UTC")

  end

end

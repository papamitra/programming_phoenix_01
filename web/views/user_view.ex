defmodule Rumble.UserView do
  use Rumble.Web, :view

  alias Rumble.User

  def first_name(%User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end

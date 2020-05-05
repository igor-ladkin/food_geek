defmodule FoodGeek.Cookbook.Image do
  use Arc.Definition
  use Arc.Ecto.Definition

  @versions [:original]

  def acl(:original, _) do
    :public_read
  end

  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png)
    |> Enum.member?(Path.extname(file.file_name))
  end

  def storage_dir(_version, {_file, _scope}) do
    "cookbook"
  end
end

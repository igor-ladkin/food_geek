defmodule FoodGeek.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias FoodGeek.Services

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
  end

  @doc false
  def registration_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password, :password_confirmation], empty_values: [])
    |> validate_length(:password, min: 4)
    |> validate_confirmation(:password, required: true)
    |> validate_email_domain()
    |> put_pass_hash()
  end

  defp validate_email_domain(%Ecto.Changeset{valid?: true, changes: %{email: email}} = changeset) do
    domain =
      email
      |> String.split("@", parts: 2)
      |> List.last()

    if Services.Dns.lookup(domain, :in, :mx) == [] do
      add_error(changeset, :email, "has no corresponding email server")
    else
      changeset
    end
  end

  defp validate_email_domain(changeset), do: changeset

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end

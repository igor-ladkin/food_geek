defmodule FoodGeekWeb.My.RecipeController do
  use FoodGeekWeb, :controller

  alias FoodGeek.Cookbook
  alias FoodGeek.Cookbook.Recipe

  def index(conn, _params, current_user) do
    recipes = Cookbook.list_chef_recipes(current_user)
    render(conn, "index.html", recipes: recipes)
  end

  def new(conn, _params, _current_user) do
    changeset = Cookbook.change_recipe(%Recipe{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"recipe" => recipe_params}, current_user) do
    case Cookbook.create_recipe(current_user, recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe created successfully.")
        |> redirect(to: Routes.my_recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    recipe = Cookbook.get_chef_recipe!(current_user, id)
    render(conn, "show.html", recipe: recipe)
  end

  def edit(conn, %{"id" => id}, current_user) do
    recipe = Cookbook.get_chef_recipe!(current_user, id)
    changeset = Cookbook.change_recipe(recipe)
    render(conn, "edit.html", recipe: recipe, changeset: changeset)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}, current_user) do
    recipe = Cookbook.get_chef_recipe!(current_user, id)

    case Cookbook.update_recipe(recipe, recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, gettext("Recipe updated successfully."))
        |> redirect(to: Routes.my_recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", recipe: recipe, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    recipe = Cookbook.get_chef_recipe!(current_user, id)
    {:ok, _recipe} = Cookbook.delete_recipe(recipe)

    conn
    |> put_flash(:info, gettext("Recipe deleted successfully."))
    |> redirect(to: Routes.my_recipe_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
end

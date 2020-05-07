defmodule FoodGeekWeb.PublicationController do
  use FoodGeekWeb, :controller

  alias FoodGeek.Cookbook

  def create(conn, %{"recipe_id" => recipe_id}, current_user) do
    recipe = Cookbook.get_chef_recipe!(current_user, recipe_id)

    case Cookbook.publish_recipe(recipe) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, gettext("Recipe published successfully."))
        |> redirect(to: Routes.recipe_path(conn, :show, recipe))

      {:error, :already_published} ->
        conn
        |> put_flash(:error, gettext("Recipe is already published."))
        |> redirect(to: Routes.recipe_path(conn, :show, recipe))
    end
  end

  def delete(conn, %{"recipe_id" => recipe_id}, current_user) do
    recipe = Cookbook.get_chef_recipe!(current_user, recipe_id)

    case Cookbook.unpublish_recipe(recipe) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, gettext("Recipe marked as draft successfully."))
        |> redirect(to: Routes.recipe_path(conn, :show, recipe))

      {:error, :not_published} ->
        conn
        |> put_flash(:error, gettext("Recipe has not been published yet."))
        |> redirect(to: Routes.recipe_path(conn, :show, recipe))
    end
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
end

defmodule FoodGeek.Services.Dns do
  require Logger

  defmodule InetRes do
    def lookup(domain, class, type) do
      Logger.info("Resoling MX record for #{domain}")

      domain
      |> to_charlist()
      |> :inet_res.lookup(class, type)
    end
  end

  defmodule Mock do
    def lookup("badexample.com", :in, :mx) do
      []
    end

    def lookup(domain, :in, :mx) do
      server = to_charlist("mx1.#{domain}")
      [{10, server}]
    end
  end

  def lookup(domain, :in, :mx) do
    adapter().lookup(domain, :in, :mx)
  end

  defp adapter do
    case Application.get_env(:food_geek, :dns) do
      :system ->
        InetRes

      _ ->
        Mock
    end
  end
end

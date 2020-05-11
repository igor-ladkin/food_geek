defmodule FoodGeek.Accounts.Dns.InetRes do
  @behaviour FoodGeek.Accounts.Dns

  require Logger

  def lookup(domain, class, type) do
    Logger.info("Resoling MX record for #{domain}")

    domain
    |> to_charlist()
    |> :inet_res.lookup(class, type)
  end
end

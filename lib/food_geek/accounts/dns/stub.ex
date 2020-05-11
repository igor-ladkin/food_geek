defmodule FoodGeek.Accounts.Dns.Stub do
  @behaviour FoodGeek.Accounts.Dns

  def lookup("badexample.com", :in, :mx) do
    []
  end

  def lookup(domain, :in, :mx) do
    server = to_charlist("mx1.#{domain}")
    [{10, server}]
  end
end

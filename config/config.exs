# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :advertize,
  ecto_repos: [Advertize.Repo]

# Configures the endpoint
config :advertize, AdvertizeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Wum16gu3Oq9vJf0sgiP1Gn7cCsqAcoeRAwrwZgkmEgT88rVpql3pHenWu6NpkYJv",
  render_errors: [view: AdvertizeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Advertize.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures for user authentication
config :advertize, Advertize.Auth.Guardian,
  issuer: "advertize",
  secret_key: "KMVLi9ySxbuP1mszfuAUef0xBH59dpMfPtFVyNeSp52vYqglGbgcaqbKroYqez3F"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

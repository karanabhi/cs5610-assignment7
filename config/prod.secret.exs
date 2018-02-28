use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :tracker, TrackerWeb.Endpoint,
  secret_key_base: "Wf1CZDkb5mejUP9kNmBWpT56aJwL9PZY5uqjjgYS8/08neN5I9+NVQkd4vO+Qgyo"

# Configure your database
config :tracker, Tracker.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "tracker_prod",
  pool_size: 15

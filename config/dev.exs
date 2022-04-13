import Config

config :solar, :root_uri, ""

if File.exists?("dev.local.exs"), do: import_config("dev.local.exs")

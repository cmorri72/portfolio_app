# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

Rails.application.config.eager_load_paths
run Rails.application
Rails.application.load_server

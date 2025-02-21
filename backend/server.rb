require 'rack'
require_relative 'config/routes'

# PumaでRackアプリを起動
Rack::Handler::Puma.run MyRouter, Port: 9292

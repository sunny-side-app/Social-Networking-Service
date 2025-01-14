# config.ru
require 'rack'

# Rackアプリ本体を定義
app = Proc.new do |env|
  [
    200,
    { "Content-Type" => "text/plain" },
    ["Hello from Rack!"]
  ]
end

run app

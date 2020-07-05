# frozen_string_literal: true

require 'json'
require 'sinatra'
require 'sinatra/activerecord'

require './config/database'

Dir['./app/models/*.rb'].sort.each { |file| require file }
Dir['./app/services/**/*.rb'].sort.each { |file| require file }

class App < Sinatra::Base
  get '/' do
    'Hello World'
  end

  post '/webhook' do
    request.body.rewind
    result = JSON.parse(request.body.read)['queryResult']

    if result['contexts'].present?
      response = InterpretService.call(result['action'], result['contexts'][0]['parameters'])
    else
      response = InterpretService.call(result['action'], result['parameters'])
    end

    content_type :json, charset: 'utf-8'
    {
      "payload": {
        "telegram": {
          "text": response,
          "parse_mode": 'Markdown'
        }
      }
    }.to_json

    # content_type :json
    # {
    #   "speech": response,
    #   "displayText": response,
    #   "source": 'OneBitBot'
    # }.to_json
  end
end

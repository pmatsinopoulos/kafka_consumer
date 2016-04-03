class TestController < ApplicationController
  def perform_async
    puts "Params: #{params.inspect}"
    resource_type   = params["resource_type"]
    action = params["action"]
    if resource_type == 'author' && action == 'create'
      puts "About to create the Author: #{params['resource']}"
      name = params['resource']['name']
      actor = Author.new(name: name)
      actor.save!
      # need to write an ack message to "test_ack" topic
      sleep(5)
      message = WaterDrop::Message.new("test_ack", {message: "author #{name} created"}.to_json)
      message.send!
    end
  end
end

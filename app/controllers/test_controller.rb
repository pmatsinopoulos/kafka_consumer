class TestController < ApplicationController
  def perform_async
    puts "Params: #{params.inspect}"
    resource_type   = params["resource_type"]
    action = params["action"]
    if resource_type == 'author' && action == 'create'
      puts "About to create the Author: #{params['resource']}"
      actor = Author.new(name: params['resource']['name'])
      actor.save!
    end
  end
end

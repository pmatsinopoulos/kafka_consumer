ENV['RACK_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] ||= ENV['RACK_ENV']

Bundler.require(:default, ENV['KARAFKA_ENV'])

Karafka::Loader.new.load(Karafka::App.root)

# App class
class App < Karafka::App
  setup do |config|
    # In most of the cases, Karafka will figure out kafka hosts automatically based on the zookeeper
    #   data. Set it manually only if you know what you are doing
    # config.kafka_hosts = %w( 127.0.0.1:9092 )
    config.zookeeper_hosts = %w( 127.0.0.1:2181 )
    config.wait_timeout = 60 # 1 minute
    config.max_concurrency = 5
    config.name = 'example_app'
    config.redis = {
      url: 'redis://localhost:6379'
    }

    routes.draw do
      topic :domain_model do
        controller TestController
        # interchanger CustomInterchanger
      end
    end
  end
end

Mongoid.load!(File.join(File.expand_path('..', __FILE__), "config", "mongoid.yml"))

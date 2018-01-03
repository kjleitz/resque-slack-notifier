require 'yaml'
require 'slack-notifier'
require 'pry-remote'

module Resque
  module Failure
    class SlackNotifier < Base
      DEFAULT_CONFIG_OPTIONS = {
        channel:        "#general",
        display_name:   "Resque worker failure",
        notify_channel: false
      }.freeze

      class << self
        attr_accessor :config, :client

        def configure(**options)
          valid_keys      = %i(webhook_url channel display_name notify_channel)
          config_options  = options.select { |key| valid_keys.include? key }

          self.config = DEFAULT_CONFIG_OPTIONS.merge config_options
          self.client = Slack::Notifier.new config[:webhook_url],
            channel:  config[:channel],
            username: config[:display_name]

          binding.pry_remote
        end

        def config_path=(path)
          configure YAML.load_file(path).symbolize_keys
        end

        def count
          Stat[:failed]
        end
      end

      def client
        self.class.client
      end

      def config
        self.class.config
      end

      def save
        raise "Client not configured" unless client && config

        message = [
          "#{"<!channel> " if config[:notify_channel]}Resque worker failure!",
          "Worker: #{worker}",
          "Queue:  #{queue}",
          "Job:    #{payload['class']}",
          "Args:   #{payload['args']}"
        ].join "\n"

        client.ping message
      end
    end
  end
end

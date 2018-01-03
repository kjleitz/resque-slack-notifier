# ResqueSlackNotifier

Sends a message to Slack whenever a Resque job raises an uncaught exception.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resque_slack_notifier'
```

And then do a `bundle install`:

```
$ bundle
```

## Setup

Configure the notifier in `config/initializers/resque.rb`:

```ruby
require "resque/failure/multiple"
require "resque/failure/redis"
require "resque/failure/slack_notifier"

Resque::Failure::SlackNotifier.configure(
  webhook_url:  "your slack webhook url",
  channel:      "#some-channel-name",
  display_name: "The Display Name for the Messages",
  notify_channel: true # if you want the messages to start with "@channel"
)

Resque::Failure::Multiple.classes = [ Resque::Failure::Redis, Resque::Failure::SlackNotifier ]
Resque::Failure.backend = Resque::Failure::Multiple
```

You can supply a YAML file for the configuration instead, and point to its path:

```ruby
require "resque/failure/multiple"
require "resque/failure/redis"
require "resque/failure/slack_notifier"
                                             # use your project's root if it's not a Rails app, obviously
Resque::Failure::SlackNotifier.config_path = File.join(Rails.root, 'path/to/slack_notifier_config.yml')

Resque::Failure::Multiple.classes = [ Resque::Failure::Redis, Resque::Failure::SlackNotifier ]
Resque::Failure.backend = Resque::Failure::Multiple
```

...where `path/to/slack_notifier_config.yml` looks like this:

```yaml
# path/to/slack_notifier_config.yml

webhook_url:    https://hooks.slack.com/services/s0m3/g4rb4g3/l1k3th1s
channel:        '#resque-failures' # or whatever channel you'd like to be notified in
display_name:   Failed Resque Job Notifier
notify_channel: true
```

The only _required_ option, no matter which configuration method you choose, is `webhook_url`. The `channel` option defaults to `"#general"`, `display_name` defaults to `"Resque worker failure"`, and `notify_channel` defaults to `false`.

## Usage

That's all there is, really. As long as you have Slack set up properly, you should get a notification any time an exception goes uncaught in a Resque job.

## Bug reports

If you encounter a bug, you can report it at https://github.com/kjleitz/resque_slack_notifier/issues. Please include the following information, if possible:

- the contents of your `config/initializers/resque.rb` file
- the contents of your configuration `.yml` file (if applicable)
- your soul (for eating)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kjleitz/resque_slack_notifier.

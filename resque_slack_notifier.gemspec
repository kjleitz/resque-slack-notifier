# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "resque_slack_notifier/version"

Gem::Specification.new do |spec|
  spec.name          = "resque_slack_notifier"
  spec.version       = ResqueSlackNotifier::VERSION
  spec.authors       = ["Keegan Leitz"]
  spec.email         = ["kjleitz@gmail.com"]

  spec.summary       = %q{Slack notifier for failed Resque jobs}
  spec.description   = %q{Resque::Failure back-end which sends a Slack message whenever a Resque worker fails.}
  spec.homepage      = "https://github.com/kjleitz/resque_slack_notifier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_dependency "slack-notifier", "~> 1.5"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake",    "~> 10.0"
end

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

ENV['SECRET_KEY_BASE_DUMMY'] = "1"

require "bundler/setup" # Set up gems listed in the Gemfile.

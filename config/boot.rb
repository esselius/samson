# frozen_string_literal: true
require 'bundler/setup'

raise "ENV clearing failed" if File.expand_path(ENV.fetch("BUNDLE_GEMFILE")) != File.expand_path("Gemfile")

ENV["RAILS_ENV"] = "test" if ARGV[0] == "test" # configure test env early for `bundle exec rails test some_test.rb`
require_relative 'dotenv'

rails_env = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
if ['development', 'test'].include?(rails_env)
  require 'bootsnap'
  Bootsnap.setup(
    cache_dir:            'tmp/bootsnap', # Path to your cache
    development_mode:     rails_env == "development",
    load_path_cache:      true, # optimizes the LOAD_PATH with a cache
    autoload_paths_cache: true, # optimizes ActiveSupport autoloads with cache
    disable_trace:        true, # Sets `RubyVM::InstructionSequence.compile_option = { trace_instruction: false }`
    compile_cache_iseq:   (rails_env != "test"), # compiles Ruby code into ISeq cache .. breaks coverage reporting
    compile_cache_yaml:   true # compiles YAML into a cache
  )
end

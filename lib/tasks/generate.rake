require 'dry/inflector'

# TODO: clean code
def build_model(model, inflector)
  class_model = inflector.classify(model)
  path = "app/models/#{model}.rb"
  File.open(path, 'w') do |file|
    file.puts <<~RUBY
      class #{class_model} < ApplicationModel
      end
    RUBY
  end

  puts "create: #{path}"
end

def build_fixture(model, inflector)
  pluralize_model = inflector.pluralize(model)
  path = "test/fixtures/#{pluralize_model}.yml"
  File.open(path, 'w') do |file|
    file.puts <<~RUBY
      one:
        text: MyString

      two:
        text: MyString
    RUBY
  end

  puts "create: #{path}"
end

def build_test(model, inflector)
  pluralize_model = inflector.pluralize(model)
  class_model = inflector.classify(model)
  path = "test/models/#{model}_test.rb"
  File.open(path, 'w') do |file|
    file.puts <<~RUBY
      require_relative '../test_helper'

      class #{class_model}Test < TestHelper
        def setup
          @#{model} = #{pluralize_model}(:one)
        end
      end
    RUBY
  end

  puts "create: #{path}"
end

def build_migration(model, inflector)
  pluralize_model = inflector.pluralize(model)
  class_model = inflector.classify(model)
  path = "test/models/#{model}_test.rb"
  File.open(path, 'w') do |file|
    file.puts <<~RUBY
      require_relative '../test_helper'

      class #{class_model}Test < TestHelper
        def setup
          @#{model} = #{pluralize_model}(:one)
        end
      end
    RUBY
  end

  puts "create: #{path}"
end

namespace :generate do
  desc 'Generate a model'
  task :model, [:name] do |_t, args|
    model = args[:name]
    inflector = Dry::Inflector.new

    build_model(model, inflector)
    build_fixture(model, inflector)
    build_test(model, inflector)
    Rake::Task['db:create_migration'].invoke("create_#{model}")
  end
end

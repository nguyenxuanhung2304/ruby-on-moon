require 'dry/inflector'

# TODO: clean code
def build_model(model, inflector)
  class_model = inflector.classify(model)
  path = "app/models/#{model}.rb"
  dirname = File.dirname(path)
  FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
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
  dirname = File.dirname(path)
  FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
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

def build_model_test(model, inflector)
  pluralize_model = inflector.pluralize(model)
  class_model = inflector.classify(model)
  path = "test/models/#{model}_test.rb"
  dirname = File.dirname(path)
  FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
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
  dirname = File.dirname(path)
  FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
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

def build_controller(controller, inflector)
  pluralize_model = inflector.pluralize(controller)
  controller = inflector.classify("#{pluralize_model}Controller")
  helper = inflector.classify("#{pluralize_model}Helper")
  path = "app/controllers/#{pluralize_model}_controller.rb"
  dirname = File.dirname(path)
  FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
  File.open(path, 'w') do |file|
    file.puts <<~RUBY
      require_relative '../helpers/admins_helper'

      class #{controller} < ApplicationController
        include #{helper}
      end
    RUBY
  end

  puts "create: #{path}"
end

def build_controller_helper(controller, inflector)
  pluralize_model = inflector.pluralize(controller)
  helper = inflector.classify("#{pluralize_model}Helper")
  path = "app/helpers/#{pluralize_model}_helper.rb"
  dirname = File.dirname(path)
  FileUtils.mkdir_p(dirname) unless File.directory?(dirname)
  File.open(path, 'w') do |file|
    file.puts <<~RUBY
      module #{helper}
      end
    RUBY
  end

  puts "create: #{path}"
end

namespace :generate do
  inflector = Dry::Inflector.new

  desc 'Generate a model'
  task :model, [:name] do |_t, args|
    model = args[:name]

    build_model(model, inflector)
    build_fixture(model, inflector)
    build_model_test(model, inflector)
    Rake::Task['db:create_migration'].invoke("create_#{model}")
  end

  desc 'Generate a controller'
  task :controller, [:name] do |_t, args|
    controller = args[:name]

    build_controller(controller, inflector)
    build_controller_helper(controller, inflector)
  end
end

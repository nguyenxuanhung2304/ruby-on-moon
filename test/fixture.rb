require 'pry'
require 'yaml'
require 'dry/inflector'

require_relative '../loader'
require_relative '../db/database'

Sequel::Model.db = DB::Database.instance.connect
Loader.new.load_test

# FIXME: clean code
module Fixture
  BASE_DIR = 'test/fixtures'.freeze

  entries = Dir.entries(BASE_DIR)
  files = entries.select do |entry|
    entry != '.' && entry != '..'
  end
  models = files.map { |f| File.basename(f, '.yml') }

  models.each do |model|
    define_method model do |key|
      inflector = Dry::Inflector.new
      fixture_relative_path = "test/fixtures/#{model}.yml"
      fixture_path = File.join(Dir.pwd, fixture_relative_path)
      fixture_hash = YAML.load_file(fixture_path)
      model_class = inflector.camelize(inflector.singularize(model))
      klass = Object.const_get(model_class)
      fixture_value = fixture_hash[key.to_s]
      raise "#{key} not found in #{fixture_relative_path}" if fixture_value.nil?

      klass.new(fixture_value)
    end
  end
end

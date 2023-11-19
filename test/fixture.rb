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
      fixture_path = File.join(Dir.pwd, "test/fixtures/#{model}.ml")
      fixture_hash = YAML.load_file(fixture_path)
      model_class = inflector.camelize(inflector.singularize(model))
      klass = Object.const_get(model_class)
      klass.new(fixture_hash[key.to_s])
    end
  end
end

require 'zeitwerk'
require_relative 'utils/file_parser'
require_relative 'db/database'

class Loader
  ALLOW_DIRS = %w[app config utils middleware].freeze
  EXCEPT_DIRS = %w[db/migrations].freeze

  attr_reader :loader

  include FileParser

  def initialize
    DB::Database.instance
    @loader = Zeitwerk::Loader.new
  end

  def load
    EXCEPT_DIRS.each { |dir| loader_ignore(dir) }.freeze
    ALLOW_DIRS.each { |dir| load_dir(dir, method(:loader_push)) }
    loader.setup
  end

  private

  def loader_push(dir)
    loader.push_dir(File.join(Dir.pwd, dir))
  end

  def loader_ignore(dir)
    loader.ignore(File.expand_path(dir, __dir__))
  end
end

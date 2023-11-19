require 'zeitwerk'
require_relative 'utils/file_parser'

# A class responsible for loading application files using Zeitwerk.
class Loader
  ALLOW_DIRS = %w[app config utils middleware].freeze
  EXCEPT_DIRS = %w[db/migrations].freeze
  TEST_DIRS = %w[app].freeze

  attr_reader :loader

  include FileParser

  # Initialize the Loader and set up Zeitwerk.
  def initialize
    @loader = Zeitwerk::Loader.new
  end

  # Load application files using Zeitwerk.
  def load
    EXCEPT_DIRS.each { |dir| loader_ignore(dir) }.freeze
    ALLOW_DIRS.each { |dir| load_dir(dir, method(:loader_push)) }
    loader.setup
  end

  def load_test
    TEST_DIRS.each { |dir| load_dir(dir, method(:loader_push)) }
    loader.setup
  end

  private

  # Push a directory to Zeitwerk for loading.
  #
  # @param dir [String] The directory path to load files from.
  def loader_push(dir)
    loader.push_dir(File.join(Dir.pwd, dir))
  end

  # Ignore a directory so that Zeitwerk won't load files from it.
  #
  # @param dir [String] The directory path to ignore.
  def loader_ignore(dir)
    loader.ignore(File.expand_path(dir, __dir__))
  end
end

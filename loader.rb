require 'zeitwerk'

class Loader
  attr_reader :loader

  def initialize
    @loader = Zeitwerk::Loader.new
  end

  def load
    load_dir('app')
    load_dir('config')
    load_dir('utils')
    load_dir('middleware')
    loader.setup
  end

  private

  def load_dir(base_dir)
    subdirs = subdirectories(base_dir)
    return loader.push_dir(File.expand_path(base_dir)) if subdirs.empty?

    subdirs.each do |subdir|
      loader.push_dir(File.expand_path("app/#{subdir}", __dir__))
    end
  end

  def subdirectories(base_dir)
    entries = Dir.entries(base_dir)
    entries.select do |entry|
      entry != '.' && entry != '..' && File.directory?(File.join(base_dir, entry))
    end
  end
end

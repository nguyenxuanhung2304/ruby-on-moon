require 'sequel'
require 'rake'
require 'pry'

require_relative 'utils/file_parser'
require_relative 'db/database'

# @class RakeTask
# Load all rake tasks in lib/tasks directory
class RakeTask
  extend FileParser

  # @method initialize
  # Load all rake tasks in lib/tasks directory.
  # @return [RakeTask]
  def initialize
    RakeTask.load_files('lib/tasks')
  end
end

RakeTask.new

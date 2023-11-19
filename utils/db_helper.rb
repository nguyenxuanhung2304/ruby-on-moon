require 'dotenv/load'
require 'erb'
require 'yaml'
require_relative '../constant'

# DbHelper: Use for database
module DbHelper
  def load_db_config
    config_path = File.join(Dir.pwd, Constant::DATABASE_CONFIG_PATH)
    yaml_config = File.read(config_path)
    erb_config = ERB.new(yaml_config).result
    YAML.safe_load(erb_config, aliases: true)
  end

  private

  # Pluralizes a file name by replacing 'y' with 'ies' or adding 's' if not already plural.
  #
  # @param file_name [String] The file name to be pluralized.
  # @return [String] The pluralized file name.
  def pluralize_file_name(file_name)
    basename = File.basename(file_name, '.rb')
    plural_name = basename.gsub(/y$/, 'ies')
    plural_name = "#{plural_name}s" if plural_name == basename
    plural_name
  end
end

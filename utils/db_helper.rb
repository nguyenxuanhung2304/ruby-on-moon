require 'dotenv/load'
require 'erb'
require 'yaml'
require_relative '../constant'

# DbHelper: Use for database
module DbHelper
  # Requires model files and loads them into the application if their corresponding database tables exist.
  #
  # This method looks for model files in the 'app/models' directory, pluralizes the file names, and checks if the
  # corresponding database tables exist. If a table exists for a model, it requires and loads the model file.
  #
  # @return [void]
  def require_models
    Sequel::Model.db = DB::Database.instance.connect

    models.each do |file_name|
      plural_name = pluralize_file_name(file_name)
      table_existed = Sequel::Model.db.table_exists?(plural_name.to_sym)

      # If the database table exists for the model, require and load the model file
      if table_existed
        path = File.join(Dir.pwd, Constant::MODEL_PATH, file_name)
        require_relative(path)
      end
    end
  end

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

  def models
    Dir.entries(Constant::MODEL_PATH).select do |f|
      File.file?(File.join(Constant::MODEL_PATH, f))
    end
  end
end

# DbHelper: Use for database
module DbHelper
  # Requires model files and loads them into the application if their corresponding database tables exist.
  #
  # This method looks for model files in the 'app/models' directory, pluralizes the file names, and checks if the
  # corresponding database tables exist. If a table exists for a model, it requires and loads the model file.
  #
  # @return [void]
  def require_models
    base_dir = 'app/models'

    # Get a list of file names in the 'app/models' directory
    file_names = Dir.entries(base_dir).select do |f|
      File.file?(File.join(base_dir, f))
    end

    file_names.each do |file_name|
      plural_name = pluralize_file_name(file_name)
      table_existed = DATABASE.table_exists?(plural_name.to_sym)

      # If the database table exists for the model, require and load the model file
      require File.join(Dir.pwd, base_dir, file_name) if table_existed
    end
  end

  private

  # Pluralizes a file name by replacing 'y' with 'ies' or adding 's' if not already plural.
  #
  # @param file_name [String] The file name to be pluralized.
  # @return [String] The pluralized file name.
  def pluralize_file_name(file_name)
    basename = File.basename(file_name, '.rb')
    plural_name = basename.gsub(/y$/, 'ies')
    plural_name = "#{file_name}s" if plural_name == file_name
    plural_name
  end
end
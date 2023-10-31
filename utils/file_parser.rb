# FileParser
module FileParser
  # Push directories of base_dir to callback
  # @param base_dir [String] Base of direcotry
  # @param callback [Function] The callback will give subdir of base_dir
  # @return [void]
  def load_dir(base_dir, callback)
    subdirs = subdirectories(base_dir)
    return callback.call(base_dir) if subdirs.empty?

    subdirs.each do |subdir|
      callback.call("#{base_dir}/#{subdir}")
    end
  end

  # Load all files in base_dir
  # @param base_dir [String] Base of direcotry
  # @return [void]
  def load_files(base_dir)
    file_names = Dir.entries(base_dir).select do |f|
      File.file?(File.join(base_dir, f))
    end

    file_names.each do |file_name|
      load File.join(base_dir, file_name)
    end
  end

  private

  # Get all subdirectories in base_dir
  # @param base_dir [String] Base of direcotry
  # @return [Array] subdirectories in base_dir
  def subdirectories(base_dir)
    entries = Dir.entries(base_dir)
    entries.select do |entry|
      entry != '.' && entry != '..' && File.directory?(File.join(base_dir, entry))
    end
  end
end

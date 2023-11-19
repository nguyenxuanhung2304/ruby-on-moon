namespace :generate do
  desc 'Generate a model'
  task :model, [:name] do |_t, args|
    puts "Generate a #{args[:name]} model"
  end
end

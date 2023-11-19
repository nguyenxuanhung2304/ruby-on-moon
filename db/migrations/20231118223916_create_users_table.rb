Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :name
      Integer :age
    end
  end
end

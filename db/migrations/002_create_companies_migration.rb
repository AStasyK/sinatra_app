Sequel.migration do
  change do
    create_table!(:companies, :ignore_index_errors=>true) do
      primary_key :id
      String :name, text: true, null: false
      String :location, text: true, null: false

      DateTime :created_at
      DateTime :updated_at

      index :id

    end
  end
end
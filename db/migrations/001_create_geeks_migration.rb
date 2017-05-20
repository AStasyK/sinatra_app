Sequel.migration do
  change do
    create_table!(:geeks, :ignore_index_errors=>true) do
      primary_key :id
      String :name, text: true, null: false
      String :stack, text: true, null: false
      TrueClass :resume, default: false

      DateTime :created_at
      DateTime :updated_at

      index :id

    end
  end
end

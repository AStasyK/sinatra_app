Sequel.migration do
  change do
    create_table!(:applies, :ignore_index_errors=>true) do
      primary_key :id
      TrueClass :read, default: false
      TrueClass :invited, default: false
      foreign_key :job_id, :jobs, null: false, key: [:id]
      foreign_key :geek_id, :geeks, null: false, key: [:id]

      DateTime :created_at
      DateTime :updated_at

      index :id

    end
  end
end
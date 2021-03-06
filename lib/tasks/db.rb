require 'rake'
require 'dotenv/tasks'
require 'sequel'
require 'sequel/extensions/seed'

namespace :db do

  require 'sequel'
  Sequel.extension :migration
  environment = ENV['RACK_ENV'] || 'development'
  ENV['DATABASE'] = 'sinatra_dev' if environment == 'development'
  ENV['DATABASE'] = 'sinatra_test' if environment == 'test'
  ENV['DATABASE'] = 'sinatra_prod' if environment == 'production'
  # connection_string = ENV['DATABASE_URL'] || ENV["DATABASE_URL_#{environment.upcase}"]
  migrations_directory = 'db/migrations'
  connection_string = "postgres://rails_admin:password@localhost/#{ENV['DATABASE']}"
  puts "ENV['DATABASE'] = #{ENV['DATABASE'].inspect}"
  puts "connection_string = #{connection_string.inspect}"

  DB = Sequel.connect(connection_string)
  desc "Prints current schema version"
  task :version do
    puts "Sinatra::Application.settings = #{Sinatra::Application.settings.inspect}"
    puts "Sinatra::Application.environment = #{Sinatra::Application.environment.inspect}"
    puts "ENV['RACK_ENV'] = #{ENV['RACK_ENV'].inspect}"
    puts "environment = #{environment.inspect}"
    puts "ENV['DATABASE_URL'] = #{ENV['DATABASE_URL'].inspect}"
    puts "DB[:schema_info].first = #{DB[:schema_info].first.inspect}"
    version = if DB.tables.include?(:schema_info)
                DB[:schema_info].first[:version]
              end || 0
    puts "Schema Version: #{version}"
  end

  desc 'Run migrations up to specified version or to latest.'
  task :migrate, [:version] => [:dotenv] do |_, args|
    version = args[:version]
    raise "Missing Connection string" if connection_string.nil?
    # DB = Sequel.connect(connection_string)
    message = if version.nil?
                Sequel::Migrator.run(DB, migrations_directory)
                'Migrated to latest'
              else
                Sequel::Migrator.run(DB, migrations_directory, target: version.to_i)
                "Migrated to version #{version}"
              end
    puts message if environment != 'test'
  end

  desc "Perform rollback to specified target or full rollback as default"
  ## ??
  task :seed do
    puts 'seed task running'
    Sequel::Seed.setup :development
    Sequel.extension :seed
    Sequel::Seeder.apply(DB, './seeds')

    # seed_file = File.join('./seeds/*.rb')
    # puts "seed_file = #{seed_file}"
    # load(seed_file) if File.exist?(seed_file)

    # dataset_comp = DB[:companies]
    # dataset_comp.insert(name: 'BuildEmpire', location: 'London')
    # dataset_comp.insert(name: 'Apple', location: 'LA')

  end


  desc "Perform rollback to specified target or full rollback as default"
  task :rollback, :target do |t, args|
    args.with_defaults(target: 0)
    Sequel::Migrator.run(DB, migrations_directory, :target => args[:target].to_i)
    Rake::Task['DB:version'].execute
  end

  desc "Perform migration reset (full rollback and migration)"
  task :reset do
    Sequel::Migrator.run(DB, migrations_directory, target: 0)
    Sequel::Migrator.run(DB, migrations_directory)
    Rake::Task['DB:version'].execute
  end
end
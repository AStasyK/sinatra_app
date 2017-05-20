Sequel.seed(:development, :test) do # Applies only to "development" and "test" environments
  def run
    dataset = DB[:companies]

    dataset.insert(:name => 'MoGo', :location => 'New York')
    dataset.insert(:name => 'Wirkkle', :location => 'London')
    dataset.insert(:name => 'Artesis', :location => 'Saint-Petersburg')
    dataset.insert(:name => 'VK', :location => 'Moscow')
  end
end

Sequel.seed(:development, :test) do # Applies only to "development" and "test" environments
  def run
    dataset = DB[:jobs]

    dataset.insert(name: 'Sinatra React', place: 'Remote', company_id: 1)
    dataset.insert(name: 'Ruby React', place: 'Contract', company_id: 2)
    dataset.insert(name: 'React', place: 'Remote', company_id: 3)
    dataset.insert(name: 'Node React', place: 'Permanent', company_id: 1)
    dataset.insert(name: 'Ruby on Rails', place: 'Remote', company_id: 4)
    dataset.insert(name: 'Node', place: 'Permanent', company_id: 4)
    dataset.insert(name: 'Javascript CSS HTML', place: 'Permanent', company_id: 4)
  end
end
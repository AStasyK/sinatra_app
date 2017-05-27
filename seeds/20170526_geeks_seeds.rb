Sequel.seed(:development, :test) do # Applies only to "development" and "test" environments
  def run
    dataset = DB[:geeks]

    dataset.insert(name: 'Anna Ivanova', stack: 'RubyOnRails, JS', resume: true)
    dataset.insert(name: 'Nick Petrov', stack: 'Node, JS', resume: false)
    dataset.insert(name: 'Michail Smirnov', stack: 'Php, HTML', resume: true)
    dataset.insert(name: 'Petr Antonov', stack: 'Ruby, front-end', resume: true)
    dataset.insert(name: 'Nina Alekseeva', stack: 'full stack web', resume: true)
    dataset.insert(name: 'Egor Nikolaev', stack: 'C++, .NET', resume: false)
    dataset.insert(name: 'Fyodor Pletnev', stack: 'Java', resume: true)

  end
end

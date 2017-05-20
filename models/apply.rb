class Apply < Sequel::Model
  one_to_one :job
  many_to_many :geeks
end
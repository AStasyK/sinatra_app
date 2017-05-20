class Geek < Sequel::Model
  many_to_many :applies
end
class Product < ApplicationRecord
  belongs_to :manufacturer
  has_and_belongs_to_many :users
  has_many :reviews
  
end

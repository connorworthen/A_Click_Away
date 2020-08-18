class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :products
  has_many :reviews
  has_many :manufacturers, through: :products 
    
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true 
  validates :username, presence: true, uniqueness: true

end
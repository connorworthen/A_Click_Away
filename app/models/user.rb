class User < ApplicationRecord
  has_secure_password
  has_and_belongs_to_many :products
  has_many :reviews
  has_many :manufacturers, through: :products 

  has_many :received_follows, foreign_key: :followed_user_id, class_name: "Follow" 
  has_many :followers, through: :received_follows, source: :follower 
  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow" 
  has_many :followings, through: :given_follows, source: :followed_user 
    
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true 
  validates :username, presence: true, uniqueness: true
  
  def following?(other_user)
    followings.include?(other_user)
  end
   
  def follow(other_user)
    followings.update()
  end

  def unfollow(other_user)
    followings.find_by(followed_user_id: other_user).destroy
  end

end
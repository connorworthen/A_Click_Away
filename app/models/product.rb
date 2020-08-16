class Product < ApplicationRecord
  belongs_to :manufacturer
  has_and_belongs_to_many :users
  has_many :reviews
  
  accepts_nested_attributes_for :manufacturer, reject_if: proc {|attr| attr['name'].blank? }
  accepts_nested_attributes_for :reviews 

  scope :alphabetize, -> (m_id){where(manufacturer_id: m_id).order('name asc')}

  def avg_rating
    if self.reviews.count < 1 
      "No reviews"
    else 
      sum = self.reviews.map {|review| review['rating']}.inject(0, :+)
      avg = (sum / self.reviews.count).round(2)
    end 
  end 

  def self.search(search)
    if search
      product_type = Product.find_by(name: search)
      if product_type
        self.where(product_id: product_type)
      else
        @products = Product.all
      end
    else
      @products = Product.all
    end
  end

end

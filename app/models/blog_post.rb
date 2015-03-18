class BlogPost < ActiveRecord::Base
  belongs_to :user 
  validates :title,presence: true, length: {maximum: 70},case_sensitive: false
  validates :post,presence: true, length: {maximum: 400,minimum: 25}
  
def self.search(query)
  where("title like ?","%#{query}%")
end
end

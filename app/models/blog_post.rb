class BlogPost < ActiveRecord::Base
  belongs_to :user 
  validates :title,presence: true
  validates :post,presence: true
  
def self.search(query)
  where("title like ?","%#{query}%")
end
end

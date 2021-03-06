class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :blog_posts, dependent: :destroy
  
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "50x50#" }, :default_url => "assets/images/:style/BlogIcon.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end

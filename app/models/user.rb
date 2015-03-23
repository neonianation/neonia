class User < ActiveRecord::Base
  # Field for e-mail signup
  attr_accessor :subscribe, :boolean
  
    # Photo
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  
  # Validations
  validates_attachment_presence :photo
  validates_attachment_content_type :photo, :content_type => /\Aimage/, :message => "needs to be an image file"
  validates :name, presence: true
  validates :email, presence: true, if: "subscribe == '1'"

  
  
end

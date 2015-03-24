class User < ActiveRecord::Base
  # Field for e-mail signup
  attr_accessor :subscribe
  # require_photo is a hidden field that causes photo validation
  attr_accessor :require_photo
  
    # Photo
  has_attached_file :photo,
    :styles => {
      :original => "200x200#" },
    :convert_options => {
      :original => "-quality 75 -strip" },
  :default_url => "/images/:style/missing.png"
  
  # Validations
  validates_attachment_presence :photo, unless: "require_photo.nil?"
  validates_attachment_content_type :photo, :content_type => /\Aimage/, :message => "needs to be an image file"
  validates :name, presence: true
  validates :email, presence: true, if: "subscribe == '1'"
  #validates :email, format: {
  #  with: /.*@.*\..*/, 
  #  message: "does not appear to be a correctly formatted address" }, if: "subscribe == '1'"
  #validates :email, uniqueness: true, if: "subscribe == '1'"
  
  
end

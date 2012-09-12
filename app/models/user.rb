require 'digest/sha1'

class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_name, :email, :user_level, :hashed_password, 
  :hashed_password_confirmation, :avatar, :website, :company, :metro_area, :company_address, :phone

  EMAIL_REGEX = /^[A-Z0-9._%+_]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  PHONE_REGEX = /^\(?[0-9]{3}\)?|[0-9]{3}[-. ]? [0-9]{3}[-. ]?[0-9]{4}$/

  validates :first_name, :presence => {:message => "is required"}, :length => {:maximum => 25}
  validates :last_name, :presence => {:message => "is required"}, :length => {:maximum => 25}
  validates :user_name, :presence => {:message => "is required"}, :length => {:maximum => 25}, :uniqueness => true
  validates :email, :presence => {:message => "is required"}, :length => {:maximum => 25}, :format => {:with => EMAIL_REGEX, :on => :save}
  validates :hashed_password, :presence => true, :length => {:maximum => 25}, :confirmation => true
  validates :phone, :format => {:with => PHONE_REGEX, :message => "must be a valid number"}


  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  has_many :shared_scraps
  has_many :bookmarked_scraps, :through => :shared_scraps
  has_many :scraps, :class_name => 'Scrap', :foreign_key => 'creator_id', :order => 'updated_at DESC'

  def self.authenticate(username="", user_input_password="")
    user = User.find_by_user_name(username)
    if user && user.hashed_password == user_input_password
      return user
    else
      return false
    end
  end
end

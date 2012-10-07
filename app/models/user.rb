class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :user_name, :email, :user_level, :avatar, :metro_area, :password, :password_confirmation

  EMAIL_REGEX = /^[A-Z0-9._%+_]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  validates :first_name, :presence => {:message => 'is required'}, :length => {:maximum => 25}
  validates :last_name, :presence => {:message => 'is required'}, :length => {:maximum => 25}
  validates :user_name, :presence => {:message => 'is required'}, :length => {:maximum => 25}, :uniqueness => true
  validates :email, :presence => {:message => 'is required'}, :length => {:maximum => 25}, :format => {:with => EMAIL_REGEX, :on => :save}  
  validates :password, :confirmation => true
  validates_length_of :password, :within => 5..25, :on => :create

  has_attached_file :avatar, :styles => { :medium => '300x300>', :thumb => '100x100>' }
  has_many :scraps, :class_name => 'Scrap', :foreign_key => 'creator_id', :order => 'updated_at DESC'
  has_many :collections, :dependent => :destroy 

  before_save :create_hashed_password
  after_save :clear_password
  after_create :initiate_collections

  def self.authenticate(username="", user_input_password="")
    user = User.find_by_user_name(username)
    if user && user.password_match?(user_input_password)
      return user
    else
      return false
    end
  end
  
  def password_match?(password="")
    hashed_password == User.hash_with_salt(password, salt)
  end
  
  
  private

  def self.make_salt(username="")
     Digest::SHA1.hexdigest("time #{username} is #{Time.now} precious")
   end

   def self.hash_with_salt(password="", salt="")
     Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
   end

  
  def create_hashed_password
    unless password.blank?
      self.salt = User.make_salt(user_name) if salt.blank?
      self.hashed_password = User.hash_with_salt(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end
  
  def initiate_collections
    c = Collection.new()
    c.name = "uploaded"
    self.collections << c
    
    c = Collection.new()
    c.name = "external"
    self.collections << c
    
    c = Collection.new()
    c.name = "bookmarked"
    self.collections << c
    
  end

end

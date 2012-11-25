class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :user_level, :avatar, :metro_area, :password, :password_confirmation, :terms_and_conditions, :zipcode
  attr_accessor :password

  EMAIL_REGEX = /^[A-Z0-9._%+_]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  validates :first_name, :presence => {:message => 'is required'}, :length => {:maximum => 25}
  validates :last_name, :presence => {:message => 'is required'}, :length => {:maximum => 25}
  validates :email, :uniqueness => true, :presence => {:message => 'is required'}, :length => {:maximum => 35}, :format => {:with => EMAIL_REGEX, :on => :save}  
  validates :password, :confirmation => true
  validates :zipcode, :numericality => {:message => 'must be a valid number (no hashes)'}, :allow_nil => true 
  validates_acceptance_of :terms_and_conditions
  validates_length_of :password, :within => 5..25, :on => :create

  has_attached_file :avatar, :styles => { :medium => '300x300>', :thumb => '100x100>' }
  has_many :owned_scraps, :class_name => 'Scrap', :foreign_key => 'creator_id', :order => 'updated_at DESC', :dependent => :destroy 
  has_many :collections, :dependent => :destroy
  has_many :tabs, :foreign_key => 'user_id', :dependent => :destroy
  has_one :vendor, :dependent => :destroy

  before_save :create_hashed_password
  after_save :clear_password
  after_create :initiate_collections, :initiate_tabs

  def self.authenticate(email="", user_input_password="")
    user = User.find_by_email(email)
    if user && user.password_match?(user_input_password)
      return user
    else
      return false
    end
  end

  def fullname
    name = first_name + ' ' + last_name
    return name
  end

  def password_match?(password="")
    hashed_password == User.hash_with_salt(password, salt)
  end

  private

  def self.make_salt(email="")
    Digest::SHA1.hexdigest("time #{email} is #{Time.now} precious")
  end

  def self.hash_with_salt(password="", salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end


  def create_hashed_password
    unless password.blank?
      self.salt = User.make_salt(email) if salt.blank?
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
    
    c = Collection.new()
    c.name = "favorite"
    self.collections << c 
  end

  def initiate_tabs
    t = Tab.new()
    t.name = "pre-wedding day"
    self.tabs << t

    t = Tab.new()
    t.name = "bridal shower"
    self.tabs << t

    t = Tab.new()
    t.name = "the big day"
    self.tabs << t

  end

end
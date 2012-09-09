class Pocket < ActiveRecord::Base
  # attr_accessible :title, :body
  
  belongs_to :user
  has_and_belongs_to_many :scraps
end

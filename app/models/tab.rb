class Tab < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :tab_items
  has_many :scraps, :through => :tab_items
  validate :thing_count_within_limit, :on => :create

  belongs_to :user


  def thing_count_within_limit
    if self.user.tabs.count >= 7
      raise ActiveResource::MethodNotAllowed, "only 5 tabs max"
    end
  end

end

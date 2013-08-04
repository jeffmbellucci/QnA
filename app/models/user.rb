print "Loading User class... \n"


class User < ActiveRecord::Base
  attr_accessible :fname, :lname, :email
  
  validates :fname, :lname, :email, :presence => true
  validates :email, :uniqueness => true
  
end

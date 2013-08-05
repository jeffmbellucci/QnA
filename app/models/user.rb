print "Loading User class... \n"


class User < ActiveRecord::Base
  attr_accessible :fname, :lname, :email
  
  validates :fname, :lname, :email, :presence => true
  validates :email, :uniqueness => true
  
  has_many(:questions,
            :foreign_key => :user_id,
            :class_name => "Question",
            :primary_key => :id
  )
  def list_user_questions
    questions.all
  end
 
  def list_questions_by_others
    # questions.includes(users).where("user_id != ?", id)
    questions.where("user_id != ?", id)
  end
  
end

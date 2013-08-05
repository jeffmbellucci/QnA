p "Loading User model..."


class User < ActiveRecord::Base
  attr_accessible :fname, :lname, :email
  
  validates :fname, :lname, :email, :presence => true
  validates :email, :uniqueness => true
  
  has_many(:questions,
            :foreign_key => :user_id,
            :class_name => "Question",
            :primary_key => :id
  )
  
  has_many(:answers,
            :foreign_key => :user_id,
            :class_name => "Answer",
            :primary_key => :id
  )
  
  def list_my_questions
    questions.all
  end
 
  # def list_questions_by_others
 #    # questions.includes(users).where("user_id != ?", id)
 #    questions.where("user_id != ?", id)
 #  end
  
end

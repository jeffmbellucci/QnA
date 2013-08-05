p "loading Answer model..."

class Answer < ActiveRecord::Base
  attr_accessible :user_id, :question_id, :body
  validates :user_id, :question_id, :body, :presence => true
  
  belongs_to(:user,
              :class_name => "User",
              :foreign_key => :user_id,
              :primary_key => :id
  )
  
  belongs_to(:question,
              :class_name => "Question",
              :foreign_key => :question_id,
              :primary_key => :id
  )
  
  def self.add_answer(user, question)
    print "Please enter your answer:".blue
    p "User id: #{user.id}"
    body = gets.chomp
    answer = self.new(:user_id => user.id, :question_id => question.id, :body => body)
    if answer.valid?
      answer.save!
      print "\nYour answer has been added successfully!".green
    else
      answer.errors.full_messages.each { |error| puts error.red.blink } 
    end
  end
  
end

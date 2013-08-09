p 'loading Question model...'

class Question < ActiveRecord::Base
  attr_accessible :user_id, :body
  validates :user_id, :body, :presence => true
  
  
  belongs_to(:user,
              :class_name => "User",
              :foreign_key => :user_id,
              :primary_key => :id
  )
  has_many(:answers,
            :foreign_key => :question_id,
            :class_name => "Answer",
            :primary_key => :id
  )
  
 #SELECT question.*, user.fname AS usersname FROM questions JOIN users ON users.id = questions.user_id
  
  def self.view_all_questions
    #questions = self.select("questions.*, users.*").joins("JOIN users ON users.id = questions.id")
   questions = self.includes(:user).all
   p questions
    questions.each do |question| 
       user = question.user
      print "\n (#{question.id}) #{question.body}" + " by #{user.fname}".blue
    end
  end
  
  
  def self.add_question(user)
    print "Please enter your question:".blue
    body = gets.chomp
    question = self.new(:user_id => user.id, :body => body)
    if question.valid?
      question.save!
      print "\nYour question has been added successfully!".green
    else
      question.errors.full_messages.each { |error| puts error.red.blink } 
    end
  end
    

end

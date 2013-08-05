require 'colorize'
print "Loading interface.... \n"

class QnA_interface
  
  def initialize
    @logged_in = false
    @quit = false
    greet
    run
  end
  
  def greet
    print "\nWelcome to Questions and Answers!\n".blue.on_light_black
    sleep(0.3)
    print "\n        by Jeff B.\n".blue.on_light_black
    sleep(0.2)
  end
    
  def ask_for_account
    begin
      print "\nDo you have an account? (y/n)".blue
      input = gets.chomp.downcase
      case input
      when "y"
        login
      when "n"
        create_account
      else
        raise "invalid input"
      end
      rescue
        print "\nI'm sorry, that was not a valid entry.".red.blink 
      retry
    end
  end
  
  def login
    print "\n******** ACCOUNT LOGIN *********".blue
    print "\nPlease enter your email address:".blue
    email = gets.chomp.downcase
    @current_user = User.find_by_email(email)
    print "\nHi #{@current_user.fname}! Wellcome Back!\n".yellow
    @logged_in = true
  end
  
  def create_account
    print "Please enter first name:".blue
    fname = gets.chomp
    print "Please enter last name:".blue
    lname = gets.chomp
    print "Please enter email address:".blue
    email = gets.chomp.downcase
    user = User.new(:fname => fname, :lname => lname, :email => email)
    if user.valid?
      user.save!
      print "\nThanks #{fname}! Your account has been created successfully!".green
      print "\nPlease use #{email} to log in to your account.".blue
    else
      print_error(user)
    end
  end
   
  def run
    until @logged_in
      ask_for_account
    end
    print "\n LOGIN SUCCESSFUL!".green
    until @quit
      prompt_user
    end
    print "\nThanks for playing. Goodbye.\n\n\n".blue
  end
    
    
  def prompt_user
    print "\n\nWhat would you like to do?".blue
    sleep(0.2)
    print "\n(1) Post a question.".yellow
    print "\n(2) View your questions.".yellow
    print "\n(3) View all questions.".yellow
    print "\n(4) Answer a Question.".yellow
    sleep(0.1)
    print "\nPlease enter the number of your choice or 'q' to quit: ".blue
    input = gets.chomp.downcase
    case input
    when "1"
      Question.add_question(@current_user)
    when "2"
      view_my_questions
    when "3"
      Question.view_all_questions
    when "4"
      Question.view_all_questions
      #prompt user for which question to answer
    when "q"
      return @quit = true
    else
      print "\nI'm sorry, that item is not on the menu...".red.blink
      prompt_user
    end
  end  
    
  def print_error(object)
    object.errors.full_messages.each { |error| puts error.red.blink } 
  end
  
  
  
  def view_my_questions
    # user_questions = Question.find_all_by_user_id(@current_user.id)
    user_questions = @current_user.list_my_questions
    user_questions.each { |question| print "\n (#{question.id}) #{question.body}"}
  end
  
  def view_questions_by_other_users
    other_questions = @current_user.list_questions_by_others
    other_questions.each_with_index { |question, i| print "\n (#{i + 1}) #{question.body}"}
  end
  
    
end
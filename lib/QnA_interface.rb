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
    print "\nPlease enter your email address: ".blue
    email = gets.chomp.downcase
    user = User.find_by_email(email)
    print "\nHi #{user.fname}! Wellcome Back!\n".yellow
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
      user.errors.full_messages.each { |error| puts error.red.blink } 
    end
  end
  
   
  def run
    until @logged_in
      ask_for_account
    end
    print "\n LOGIN SUCCESSFUL!\n".green
    until @quit
      prompt_user
    end
    print "\nThanks for playing. Goodbye.\n\n\n".blue
  end
    
    
  def prompt_user
      print "\nWhat would you like to do?".blue
      sleep(0.2)
      begin
        print "\n(1) Post a question.".yellow
        sleep(0.1)
        print "\n(2) View your questions.".yellow
        sleep(0.1)
        print "\n(3) View questions by other users.".yellow
        sleep(0.1)
        print "\nPlease enter the number of your choice or 'q' to quit: ".blue
        input = gets.chomp.downcase
        case input
        when "1"
          p "lets post a question"
          post_question
        when "2"
          view_questions
        when "3"
          p "lets view all questions"
          view_questions_by_users
        when "q"
          return @quit = true
        else
          raise "invalid input"
        end
      rescue
        print "\nI'm sorry, that item is not on the menu...".red.blink
      retry
    end  
  end
    
    
  def post_question
  end
  
  def view_questions
    print "\nWould like to view by (t)itle or (b)ody?".blue
    input = gets.chomp.downcase
    case input
    when "t"
      puts "view title"
    when "b"
      puts "view body"
    end
  end
  
  def view_questions_by_users
  end
  
  def post_question
  end
    
end
class PageController < ApplicationController
  
  def index
    @user = User.new
    
    #render('_join_us')
    render('index')
  end
  
  def signup    

    # do we already have a record with this email address?
    # if so, then load that record and we'll just update the name and photo
    if User.exists?(:email => params[:user][:email])
      @user = User.find_by_email(params[:user][:email])
        
    # if not, then we'll create a new user
    else
      @user = User.new
      @user.email = params[:user][:email]
    end    
    
    # update all attributes
    @user.require_photo = params[:user][:require_photo]
    @user.name = params[:user][:name]
    @user.photo = params[:user][:photo] 
    
    respond_to do |format|
          
      # subscribe to mailchimp only if there are no errors
      if @user.valid?
        begin
          puts "Connecting to Mailchimp..."
          gb = Gibbon::API.new
          #gb.lists.subscribe({:id => ENV['MAILCHIMP_LIST_ID'], :email => {:email => @user.email}, :merge_vars => {:NAME => @user.name}, :double_optin => false})
        rescue Gibbon::MailChimpError => e
          
          # if user already subscribed, then run update
          if e.code == 214
            @user.errors.add(:base, "Someone with this email has already joined Neonia")
          # else run validations and add error message
          else
            @user.errors.add(:base, e.message)
          end
        end
      end
      
      puts "Saving user to database..."
      
      @user.save unless @user.errors.any?
      format.js
    end
  end
  
end

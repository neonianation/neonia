class PageController < ApplicationController
  
  include ApplicationHelper
  include MailerHelper
  
  def index
    
    # create new user for join-us form
    @user = User.new
    
    
    # get sample of members for call to action area
    @member_sample = User.order("RANDOM()").limit(6)
    
    render('index')
  end
  
  def signup    

    #make email lowercase
    params[:user][:email] = params[:user][:email].downcase
    
    # do we already have a record with this email address?
    # if so, then load that record and we'll just update the name and photo    
    @user = User.find_by_email ( params[:user][:email])
    if @user
      @user.errors.add(:base, "Someone with this email has already joined Neonia")
      return
        
    # if not, then we'll create a new user
    else
      @user = User.new
      @user.email = params[:user][:email]
    end    
    
    # update all attributes
    @user.require_photo = params[:user][:require_photo]
    @user.name = params[:user][:name]
    @user.photo = params[:user][:photo] 
    @user.password = generate_code
    begin
      @user.reg_code = generate_code
    end while User.exists?(reg_code: @user.reg_code)
    
    respond_to do |format|
          
      # subscribe to mailchimp only if there are no errors
      if @user.valid?
        puts "Will now attempt sending email to validate email address..."
        email_data = mail_welcome_mail @user
        
        if email_data["status"] != "sent"
          @user.errors.add(:base, "We had a problem sending you an email, are you certain that your email address is valid?")
        end
        
      end
      # if @user.valid? && Rails.env.production?
        # begin  
          # puts "Connecting to Mailchimp..."
          # gb = Gibbon::API.new
          # gb.lists.subscribe({:id => ENV['MAILCHIMP_LIST_ID'], :email => {:email => @user.email}, :merge_vars => {:NAME => @user.name, :REG_CODE => @user.reg_code}, :update_existing => true, :double_optin => false})
         # rescue Gibbon::MailChimpError => e
            # @user.errors.add(:base, e.message)
          #end
        #end
      #end
      
      if not @user.errors.any?
        puts "Saving user to database..."
        @user.save
      end
      
      format.js
    end
  end
  
end

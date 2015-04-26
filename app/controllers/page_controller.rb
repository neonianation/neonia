class PageController < ApplicationController
  
  include ApplicationHelper
  
  def index
    
    # determine if post thunderclap
    @is_post_thunderclap = Time.now > Time.parse("2015-04-13 8AM EDT")
    
    
    # create new user for join-us form
    @user = User.new
    
    
    # get sample of members for call to action area
    if @is_post_thunderclap
      @member_sample = User.order("RANDOM()").limit(6)
    end
    
    render('index')
  end
  
  def signup    

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
    @user.password = "notset"
    begin
      @user.reg_code = generate_reg_code
    end while User.exists?(reg_code: @user.reg_code)
    
    respond_to do |format|
          
      # subscribe to mailchimp only if there are no errors
      if @user.valid? && Rails.env.production?
        begin
          puts "Connecting to Mailchimp..."
          gb = Gibbon::API.new
          gb.lists.subscribe({:id => ENV['MAILCHIMP_LIST_ID'], :email => {:email => @user.email}, :merge_vars => {:NAME => @user.name, :REG_CODE => @user.reg_code}, :double_optin => false})
        rescue Gibbon::MailChimpError => e
          
          # if user already subscribed, then run update
          if e.code == 214
            #@user.errors.add(:base, "Someone with this email has already joined Neonia")
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

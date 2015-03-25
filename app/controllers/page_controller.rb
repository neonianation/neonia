class PageController < ApplicationController
  
  def index
    @user = User.new
    
    #render('_join_us')
    render('index')
  end
  
  def signup    
    # if user wants to subscribe to newsletter, then record email
    if params[:user][:subscribe] == "1"
      
      # do we already have a record with this email address?
      # if so, then load that record and we'll just update the name and photo
      if User.exists?(:email => params[:user][:email])
        @user = User.find_by_email(params[:user][:email])
        
      # if not, then we'll create a new user
      else
        @user = User.new
        @user.email = params[:user][:email]
      end    

    # if user doesn't want to subscribe, then we'll
    # not record their email    
    else 
      @user = User.new
      @user.email = nil
    end
    
    # update all attributes
    @user.require_photo = params[:user][:require_photo]
    @user.subscribe = params[:user][:subscribe]
    @user.name = params[:user][:name]
    @user.photo = params[:user][:photo] 
    
    respond_to do |format|
      
      # indicate whether user is already subscribed to mailchimp list
      @user_already_subscribed = false
      
      # subscribe to mailchimp only if there are no errors and user wants to subscribe
      if @user.valid? and @user.subscribe == "1"
        begin
          gb = Gibbon::API.new
          gb.lists.subscribe({:id => ENV['MAILCHIMP_LIST_ID'], :email => {:email => @user.email}, :merge_vars => {:NAME => @user.name}, :double_optin => true})
        rescue Gibbon::MailChimpError => e
          
          # if user already subscribed, then run update
          if e.code == 214
            gb.lists.update_member({:id => ENV['MAILCHIMP_LIST_ID'], :email => {:email => @user.email}, :merge_vars => {:NAME => @user.name}})
            @user_already_subscribed = true
          # else run validations and add error message
          else
            @user.errors.add(:base, e.message)
          end
        end
      end
      
      @user.save unless @user.errors.any?
      format.js
    end
  end
  
end

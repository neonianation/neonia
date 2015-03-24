class PageController < ApplicationController
  
  def index
    @user = User.new
    
    render('_join_us')
    #render('index')
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
      @user.save
      format.js
    end
    #if @user.save

    #end
  end
  
end

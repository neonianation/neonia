class PageController < ApplicationController
  
  def index
    @user = User.new
    
    render('_join_us')
    #render('index')
  end
  
  def signup
    @user = User.new
    @user.name = params[:user][:name]
    @user.photo = params[:user][:photo]
    
    # if user wants to subscribe to newsletter, then record email
    #if params[:user][:subscribe] == 1
      @user.email = params[:user][:email]
    #else
    #  @user.email = nil
    #end
    
    
    respond_to do |format|
      if @user.save
        format.js
      end
    end
    #if @user.save

    #end
  end
  
end

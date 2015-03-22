class PageController < ApplicationController
  
  def index
    @user = User.new
    
    render('_join_us')
    #render('index')
  end
  
  def signup
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    
    respond_to do |format|
      format.js
    end
  end
  
end

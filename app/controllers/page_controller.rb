class PageController < ApplicationController
  
  def index
    @user = User.new
    
    render('index')
  end
  
  def signup
    @user = User.new
    @user.name = params[:user][:name]
    @user.email = params[:user][:email]
    
    render ('index')
  end
  
end

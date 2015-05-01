class SessionController < ApplicationController
  include SessionHelper
  include ApplicationHelper
  include MailerHelper
  
  require 'openssl'
  require 'base64'
  require "uri"

  layout 'session'
  
  def resend_reg_code
    @has_user_already_registered = true
    
    @user = User.find_by_email(params[:email].downcase)
    
    return unless @user and @user.username.blank?
  
    @has_user_already_registered = false
    
    # send reg code email
    mail_registration_code_request @user
    
  end
  
  def password_recovery_request
    @user = User.find_by_email(params[:email].downcase)
    
    if !@user
      @user = User.find_by_username(params[:email].downcase)
    end  
    
    return unless @user
    
    # generate pwd recovery code and deadline
    @user.pwd_recov_code = generate_code
    @user.pwd_recov_date = Time.now
    
    # send password reset email
    if @user.save(:validate => false)
      mail_password_recovery_request @user
    end
    
  end
  
  def create_new_password    
    @valid_request = is_valid_password_recovery_request?
  end
  
  def save_new_password
    
    if is_valid_password_recovery_request?
      @user = User.find_by_username(params[:username])
      @user.password_required = true
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirm]
      @user.pwd_recov_code = nil
      @user.pwd_recov_date = nil
      if @user.save
        @user_password_reset_successful = true 
      end
    end
  end
  
  def register
    is_valid_registration_request?    
  end
  
  def create_account
    if is_valid_registration_request? 
    
      @user.password_required = true
      @user.username = params[:user][:username].downcase
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirm]

      @account_creation_was_successful = false

      if @user.save
        @account_creation_was_successful = true
        return_params = {
          :id => @user.registration_id,
          :code => @user.reg_code
          }
        @redirect_path = generate_url(register_path, return_params)
      end
    
    end
    
  end
  
  
  def show_login
    
    return unless params[:sig].present? and params[:sso].present? and OpenSSL::HMAC.hexdigest('sha256', ENV["DISCOURSE_SSO_SECRET"], params[:sso]) == params[:sig]
    
    @discourse_sig = URI.escape params[:sig]
    @discourse_sso = URI.escape params[:sso]
    
    #Check valid+legitness,
    # else redirect to info page informing about clicking log-in in from forum.
    
  end
    
    
  def attempt_login
    user = User.find_by_username(params[:username].downcase)
       
    @user_authentication_successful
    
    if user && user.authenticate(params[:password])
      @user_authentication_successful = true
    else
      @user_authentication_successful = false
      return
    end
    
    sig = URI.decode params[:sig]
    sso = URI.decode params[:sso]
    
    @redirect_path = nil
    
    # Check if this is a valid+legit request from forum.neonia.org
    if sig.present? and sso.present? and OpenSSL::HMAC.hexdigest('sha256', ENV["DISCOURSE_SSO_SECRET"], sso) == sig
      nonce = Base64.decode64(sso)
      sso = Base64.encode64(nonce + '&username=' + user.username + '&email=' + user.email + '&external_id=' + user.id.to_s + '&name=' + user.name + '&avatar_url=http://www.neonia.org' + user.photo.url + '&avatar_force_update=true')
      sig = OpenSSL::HMAC.hexdigest('sha256', ENV["DISCOURSE_SSO_SECRET"], sso)
      return_params = { sso: sso, sig: sig }
      @redirect_path = generate_url( ENV["DISCOURSE_URL"] + "session/sso_login", return_params )
    else
      # redirect to info page informing about clicking log-in from forum.
      @redirect_path = url_for :action => 'show_login'
    end
    
  end
  
  private
  
  # checks if the password recovery request is valid
  def is_valid_password_recovery_request?
        # end unless we've got a user and a pwd_recov_code
    return false unless params[:username].present? and params[:code].present?

    @user = User.find_by_username(params[:username])

    # end unless we found a user with that username
    return false unless @user

    # validate pwd_recov_code and expiration
    return false unless @user.pwd_recov_code.present? and @user.pwd_recov_date.present?

    request_exp = @user.pwd_recov_date + 24.hours

    return false unless @user.pwd_recov_code == params[:code] and request_exp > Time.now 

    # validations successful, return true
    return true
  end
  
  # returns true if the registration id and code are valid
  def is_valid_registration_request?
    return false unless params[:code].present? && params[:id].present?
    
    @user = User.find_by_reg_code(params[:code])
    
    return false unless @user and @user.username.blank?
    
    return false unless @user.registration_id == params[:id]
    
    return true
  end
    
end

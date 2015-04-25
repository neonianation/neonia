class SessionController < ApplicationController
  include SessionHelper
  
  require 'openssl'
  require 'base64'
  require "uri"

  layout 'session'
  
  def show_login
    
    @discourse_sig = URI.escape params[:sig]
    @discourse_sso = URI.escape params[:sso]
    
    #Check valid+legitness,
    # else redirect to info page informing about clicking log-in in from forum.
    
  end
    
    
  def attempt_login
    user = User.find_by_username(params[:username])
       
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
      sso = Base64.encode64(nonce + '&username=' + user.username + '&email=' + user.email + '&external_id=' + user.id.to_s + '&name=' + user.name)
      sig = OpenSSL::HMAC.hexdigest('sha256', ENV["DISCOURSE_SSO_SECRET"], sso)
      return_params = { sso: sso, sig: sig }
      @redirect_path = generate_url( ENV["DISCOURSE_URL"] + "session/sso_login", return_params )
    else
      # redirect to info page informing about clicking log-in from forum.
      @redirect_path = root_path
    end
    
  end
  
  # def infoPageOnMissingSIGSSO
    
end

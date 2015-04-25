class SessionController < ApplicationController
  include SessionHelper
  
  require 'openssl'
  require 'base64'

  layout 'session'
  
  def show_login
    @user = User.new
  end
    
    
  def attempt_login
    @user = User.find_by_email(params[:email])
    
    respond_to do |format|    
      format.js
    end
      
    # authenticate
    #self.resource = warden.authenticate(auth_options)
    #resource_name = self.resource_name
    #sign_in(resource_name, resource)
#    if member_signed_in?
#      # redirect to forum
#      sig = params[:sig]
#      sso = params[:sso]
#      if OpenSSL::HMAC.hexdigest('sha256', SSO_SECRET, sso) == sig
#        nonce = Base64.decode64(sso)
#        sso = Base64.encode64(nonce + '&username=' + resource.nick + '&email=' + resource.email + '&external_id=' + resource.id.to_s)
#        sig = OpenSSL::HMAC.hexdigest('sha256', SSO_SECRET, sso)
#        return_params = { sso: sso, sig: sig }
    #redirect_to generate_url ( "http://forum.neonia.org")
        #redirect_to generate_url( FORUM_URL, return_params )
#      end
#    else
#      redirect_to root_path, alert: t('.sign_in')
#    end
  end
    
end

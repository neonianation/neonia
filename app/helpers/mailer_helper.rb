module MailerHelper
  
  require 'mandrill' 
  
  # mail_password_recovery_request user
  def mail_password_recovery_request user
    m = Mandrill::API.new
    template_name = "password-recovery-request"
    template_content = []
    
    merge_vars = [{
        :rcpt => user.email,
        :vars => [
          { :name => "NAME", :content => user.name },
          { :name => "USERNAME", :content => user.username },
          { :name => "PASSWORD_RECOVERY_CODE", :content => user.pwd_recov_code }
        ]
    }]
    
    message = {
     :to =>[{  
       :email => user.email,  
       :name => user.name  
     }],
     :from_name => ENV["MANDRILL_NAME"], 
     :from_email => ENV["MANDRILL_DO_NOT_REPLY"],
     :merge_vars => merge_vars
    }
    
    sending = m.messages.send_template template_name, template_content, message
    
    puts "Sending Password Recovery Request for " + user.name
    puts sending
    
  end
  
  # mail_registration_code_request user
  def mail_registration_code_request user
    
    mail_welcome_mail user
    
  end
  
  # mail welcome user
  def mail_welcome_mail user
    
    m = Mandrill::API.new
    template_name = "welcome-to-neonia"
    template_content = []
    
    merge_vars = [{
        :rcpt => user.email,
        :vars => [
          { :name => "NAME", :content => user.name },
          { :name => "REGISTRATION_ID", :content => user.registration_id },
          { :name => "REGISTRATION_CODE", :content => user.reg_code }
        ]
    }]
    
    message = {
     :to =>[{  
       :email => user.email,  
       :name => user.name  
     }],
     :from_name => ENV["MANDRILL_NAME"], 
     :from_email => ENV["MANDRILL_DO_NOT_REPLY"],
     :merge_vars => merge_vars
    }
    
    sending = m.messages.send_template template_name, template_content, message
    
    puts "Sending Welcome Mail to " + user.email
    puts sending
        
    
  end
  
  
  def testmail
    m = Mandrill::API.new
    
    user = User.find_by_email("finn.woelm@gmail.com")
    
    template_name = "Test"
    template_content = []
    merge_vars = [
      {
        :rcpt => user.email,
        :vars => [{
          :name => "REGCODE",
          :content => user.reg_code
        }]
      }
    ]
    
    message = {  
     :subject => "Hello from the Mandrill API", 
     :to =>[  
       {  
         :email => user.email,  
         :name => user.name  
       }  
     ],  
     :from_name => ENV["MANDRILL_NAME"], 
     :from_email => ENV["MANDRILL_EMAIL"],
     :merge_vars => merge_vars
    }
    
    sending = m.messages.send_template template_name, template_content, message
    
    puts sending

    render :text => "test"
    
  end
  
end

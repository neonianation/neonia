desc "Set all passwords to random"
task :send_newsletter_001 => :environment do
  
  include MailerHelper
  
  @users = User.all
  
  to = []
  merge_vars = []
  
  puts "Creating to[] and merge_vars[]..."
  
  @users.each do |user|
    
    to << {
      :email => user.email,
      :name => user.name
      }
    
    merge_vars << {
      :rcpt => user.email,
      :vars => [
        { :name => "NAME", :content => user.name },
        { :name => "REGISTRATION_ID", :content => user.registration_id },
        { :name => "REGISTRATION_CODE", :content => user.reg_code }
        ]
      }
  
  end
    
  puts "Now sending"
    
  m = Mandrill::API.new
  template_name = "001-newsletter-neonia-core-up-and-running"
  template_content = []
    
  message = {
   :to => to,
   :from_name => ENV["MANDRILL_NAME"], 
   :from_email => ENV["MANDRILL_EMAIL"],
   :merge_vars => merge_vars
  }

  sending = m.messages.send_template template_name, template_content, message

  puts "Sending newsletter to " + @users.count.to_s + "user(s)"
  puts sending

end

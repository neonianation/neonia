desc "Set all passwords to random"
task :reset_all_passwords => :environment do
  
  include ApplicationHelper
  
  @TARGET_PASSWORD = "notset"
  
  @users = User.all
  @count_reset = 0
  @count_without_username = 0
  @users.each do |user|
        
    if user.username.blank?
      @count_without_username += 1
    
      user.password = generate_code
      if user.save
        @count_reset += 1
      else
        puts user.errors.full_messages
      end
    end
  
  end
  puts "Reset password for " + @count_reset.to_s + " user(s) out of " + @count_without_username.to_s + " user(s) without a username and " + User.count.to_s + " user(s) in total."
end

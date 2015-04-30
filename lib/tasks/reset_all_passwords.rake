desc "Set all passwords to random"
task :reset_all_passwords => :environment do
  
  include ApplicationHelper
  
  @users = User.all
  @count_reset = 0
  @users.each do |user|
        
    user.password = generate_code
    if user.save
      @count_reset += 1
    else
      puts user.errors.full_messages
    end
  
  end
  puts "Reset password for " + @count_reset.to_s + " user(s) out of " + User.count.to_s + " user(s) in total."
end

class AddPwdRecovCodePwdRecovDateTo < ActiveRecord::Migration
  def change
    add_column :users, :pwd_recov_code, :string, :default => nil, :length => "24"
    add_column :users, :pwd_recov_date, :datetime, :default => nil
  end
end

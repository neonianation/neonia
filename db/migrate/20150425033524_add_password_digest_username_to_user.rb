class AddPasswordDigestUsernameToUser < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string, :default => nil
    add_column :users, :username, :string, :default => nil
  end
end

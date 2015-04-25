class AddRegCodeToUser < ActiveRecord::Migration
  def change
    add_column :users, :reg_code, :string, :default => nil, :length => "24"
  end
end

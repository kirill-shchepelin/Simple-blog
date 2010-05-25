class AddGuestNameToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :guest_name, :string
  end

  def self.down
    remove_column :comments, :guest_name
  end
end

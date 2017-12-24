class AddAliasNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :alias_name, :string
  end
end

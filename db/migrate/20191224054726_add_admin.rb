class AddAdmin < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :is_admin, :boolean, deafult: false
  end

  def down
    remove_column :users, :is_admin
  end
end

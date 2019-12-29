class AddAdmin < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_admin, :boolean, deafult: false
  end

  def down
    remove_column :users, :is_admin
  end
end

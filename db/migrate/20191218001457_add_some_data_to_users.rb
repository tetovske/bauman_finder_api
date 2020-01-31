class AddSomeDataToUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.remove :group_id
    end
  end
end

class RemoveGroupId < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.remove :group_id
      t.belongs_to :group, foreign_key: true
    end
  end

  def down
    change_table :students do |t|
      t.remove :group_id
      t.references :group, foreign_key: true
    end
  end
end

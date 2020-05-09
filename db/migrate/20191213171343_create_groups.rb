class CreateGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.timestamps
    end

    change_table :students do |t|
      t.belongs_to :group, foreign_key: "group_id"
      t.remove :group, :company
    end
  end
end

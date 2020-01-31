class ChangeForeignKey < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.remove :group_id
      t.belongs_to :group, foreign_key: true
    end
  end
end
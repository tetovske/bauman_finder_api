class AddDataToStudents < ActiveRecord::Migration[6.0]
  def up
    change_table :students do |t|
      t.references :group, foreign_key: { to_table: :groups }
      t.references :group_adm, foreign_key: { to_table: :groups }
      t.string :subject_data
    end
  end

  def down 
    change_table :students do |t|
      t.remove :group
      t.remove :group_adm
      t.remove :subject_data
    end
  end
end

class ChangeSubjectField < ActiveRecord::Migration[6.0]
  def change
    remove_column :students, :subject_data
    add_column :students, :subject_data, :text
  end

  def down
    remove_column :students, :subject_data
    add_column :students, :subject_data, :string
  end
end

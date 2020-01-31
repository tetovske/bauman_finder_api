# frozen_string_literal: true

# Migration for students table
class FillStudentTables < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.column :first_name, :string
      t.column :last_name, :string
      t.column :mid_name, :string
      t.column :group, :string
      t.column :company, :string
      t.column :id_stud, :string
      t.column :id_abitur, :string
      t.column :exam_scores, :decimal
      t.remove :identifier
    end
  end
end

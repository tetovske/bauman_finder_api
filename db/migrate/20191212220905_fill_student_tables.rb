# frozen_string_literal: true

# Migration for students table
class FillStudentTables < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.column :name, :string
      t.column :last_name, :string
      t.column :mid_name, :string
      t.column :group, :string
      t.column :company, :string
      t.column :identifier, :string
      t.column :exam_scores, :decimal
    end
  end
end

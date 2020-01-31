class AddReferences < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.belongs_to :form_of_study, foreign_key: true
    end
  end
end

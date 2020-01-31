class AddCompanies < ActiveRecord::Migration[6.0]
  def change
    change_table :students do |t|
      t.references :company, foreign_key: { to_table: :companies }
    end
  end
end

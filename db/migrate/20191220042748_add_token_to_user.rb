class AddTokenToUser < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.string :token
    end
  end
end

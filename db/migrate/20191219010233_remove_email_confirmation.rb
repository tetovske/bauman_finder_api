class RemoveEmailConfirmation < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      t.remove :confirmation_token
      t.remove :confirmed_at
      t.remove :confirmation_sent_at
      t.remove :unconfirmed_email
    end
  end
end

class AddEmailSupport < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      change_table :users do |t|
        direction.up do
          t.string :confirmation_token
          t.datetime :confirmed_at
          t.datetime :confirmation_sent_at
          t.index :confirmation_token
        end

        direction.down do
          t.remove :confirmation_token, :confirmed_at, :confirmation_sent_at
        end
      end
    end
  end
end

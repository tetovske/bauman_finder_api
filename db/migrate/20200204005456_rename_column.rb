class RenameColumn < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      change_table :users do |t|
        direction.up do
          t.rename :token, :bf_api_token
          t.string :provider
          t.string :uid
          t.string :token
          t.string :refresh_token
          t.integer :expires_at
          t.boolean :expires
        end

        direction.down do
          t.remove :provider
          t.remove :uid
          t.remove :token
          t.remove :refresh_token
          t.remove :expires_at
          t.remove :expires
          t.rename :bf_api_token, :token
        end
      end
    end
  end
end

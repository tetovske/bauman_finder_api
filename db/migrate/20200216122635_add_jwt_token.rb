class AddJwtToken < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      change_table :users do |t|
        direction.up do
          t.rename :token, :jwt_token
        end

        direction.down do
          t.rename :jwt_token, :token
        end
      end
    end
  end
end

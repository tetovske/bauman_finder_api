class AddSomeInformationToProfile < ActiveRecord::Migration[6.0]
  def change
    reversible do |direction|
      change_table :users do |t|
        direction.up do
          t.string :image_url, :bf_username
          t.change :email, :string, default: nil, null: true
        end

        direction.down do
          t.remove :image_url, :bf_username
          t.change :email, :string, default: "", null: false
        end
      end
    end
  end
end

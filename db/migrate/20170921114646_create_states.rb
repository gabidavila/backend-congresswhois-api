class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.string :state, limit: 2, null: false
      t.string :state_full, null: false

      t.timestamps
    end

    add_index :states, :state, unique: true
    add_index :states, :state_full
  end
end

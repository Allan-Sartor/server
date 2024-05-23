class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.string :cpf, null: false
      t.string :phone, null: false
      t.string :address, null: false
      t.string :complement, default: ""
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
    add_index :contacts, :cpf, unique: true
  end
end

class AddIndexNameToContacts < ActiveRecord::Migration[7.0]
  def change
    add_index :contacts, :name
  end
end

class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string  :name
      t.string  :title
      t.string  :description
      t.integer :status
      t.integer :user_id
      t.integer :ticket_informant_id
      
      t.timestamps null: false
    end
  end
end

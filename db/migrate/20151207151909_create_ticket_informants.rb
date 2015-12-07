class CreateTicketInformants < ActiveRecord::Migration
  def change
    create_table :ticket_informants do |t|
      t.string    :username
      t.string    :email
      t.string    :phone
      t.string    :ip_addres

      t.timestamps null: false
    end
  end
end

class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :details
      t.references :user, index: true, foreign_key: true
      t.integer :price
      t.date :ends_on

      t.timestamps null: false
    end
  end
end

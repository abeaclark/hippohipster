class CreatePerformerTable < ActiveRecord::Migration
  def change
    create_table :performers do |t|
      t.integer :sk_id
      t.integer :sc_id
    end
  end
end

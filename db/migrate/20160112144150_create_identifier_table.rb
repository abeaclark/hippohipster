class CreateIdentifierTable < ActiveRecord::Migration
  def change
    create_table :identifiers do |t|
      t.string :value
      t.integer :tag_id
    end
  end
end

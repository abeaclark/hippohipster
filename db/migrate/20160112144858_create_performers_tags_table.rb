class CreatePerformersTagsTable < ActiveRecord::Migration
  def change
    create_table :performers_tags do |t|
      t.integer :performer_id
      t.integer :tag_id
    end
  end
end

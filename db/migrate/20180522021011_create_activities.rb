class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :content
      t.string :target_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

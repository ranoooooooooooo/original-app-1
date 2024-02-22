class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string     :title,   null: false
      t.integer    :type_id, null: false
      t.date       :date
      t.datetime   :start_time
      t.datetime   :end_time
      t.text       :content
      t.references :room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end

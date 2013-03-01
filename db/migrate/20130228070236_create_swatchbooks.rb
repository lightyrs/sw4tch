class CreateSwatchbooks < ActiveRecord::Migration

  def change

    create_table :swatchbooks do |t|
      t.integer :user_id
      t.string  :name
      t.text    :description

      t.timestamps
    end

    add_index :swatchbooks, :user_id
  end
end

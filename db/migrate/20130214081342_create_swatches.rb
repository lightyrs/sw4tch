class CreateSwatches < ActiveRecord::Migration

  def change

    create_table :swatches do |t|
      t.string     :name
      t.integer    :user_id
      t.text       :description
      t.text       :css
      t.text       :scss
      t.text       :stylus

      t.timestamps
    end

    # add_index :swatches, [:user_id, :name], :unique => true
    add_index :swatches, :user_id
  end
end

class CreateSwatchbooksSwatches < ActiveRecord::Migration
  def change
    create_table :swatchbooks_swatches, :id => false do |t|
      t.integer :swatchbook_id
      t.integer :swatch_id
    end
  end
end

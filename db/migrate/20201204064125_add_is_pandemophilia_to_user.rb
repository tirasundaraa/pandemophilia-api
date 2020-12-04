class AddIsPandemophiliaToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_pandemophilia, :boolean, default: true
    add_index :users, :is_pandemophilia
  end
end

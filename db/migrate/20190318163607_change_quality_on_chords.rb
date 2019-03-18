class ChangeQualityOnChords < ActiveRecord::Migration[5.2]
  def change
    change_column :chords, :quality, :string
    remove_column :chords, :substitution, :integer
    remove_column :chords, :seventh, :integer
    remove_column :chords, :ninth, :integer
  end
end

class ChangeBonusName < ActiveRecord::Migration[5.2]
  def change
    rename_column :aircrafts, :bonus, :distance_bonus
  end
end

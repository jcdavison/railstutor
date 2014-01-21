class AddAppliedToStudent < ActiveRecord::Migration
  def change
    add_column :students, :applied, :boolean
  end
end

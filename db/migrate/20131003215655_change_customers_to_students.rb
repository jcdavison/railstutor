class ChangeCustomersToStudents < ActiveRecord::Migration
  def up
    rename_table :customers, :students
  end

  def down
  end
end

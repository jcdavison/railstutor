class AddGithubLinkedinVideoToStudent < ActiveRecord::Migration
  def change
    add_column :students, :linkedin, :string
    add_column :students, :github, :string
    add_column :students, :intro_video, :string
  end
end

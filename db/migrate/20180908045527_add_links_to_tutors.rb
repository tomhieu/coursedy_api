class AddLinksToTutors < ActiveRecord::Migration[5.1]
  def change
    add_column :tutors, :facebook, :string
    add_column :tutors, :linkedin, :string
    add_column :tutors, :google_plus, :string
    add_column :tutors, :tweeter, :string
  end
end

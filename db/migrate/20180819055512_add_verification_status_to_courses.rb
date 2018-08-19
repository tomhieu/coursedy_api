class AddVerificationStatusToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :verification_status, :integer, default: 0
  end
end

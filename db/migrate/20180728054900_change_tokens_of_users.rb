class ChangeTokensOfUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :tokens, :text

    reversible do |direction|
      direction.up do
        User.find_each do |user|
          user.uid = user.email
          user.tokens = nil
          user.save!
        end
      end
    end
  end
end

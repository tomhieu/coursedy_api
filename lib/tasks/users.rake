namespace :users do
  task update_rating: :environment do |t, args|
    User.includes(:tutor_ratings).find_each do |u|
      u.update_column(:rating_count, u.tutor_ratings.count)
      u.update_column(:rating_points, u.tutor_ratings.sum(:points))
    end
  end
end
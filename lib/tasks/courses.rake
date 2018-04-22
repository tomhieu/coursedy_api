namespace :courses do
  task update_lesson_count: :environment do |t, args|
    Course.includes(:lessons).find_each do |c|
      c.update_column(:lesson_count, c.lessons.count)
    end
  end

  task update_rating: :environment do |t, args|
    Course.includes(:course_ratings).find_each do |c|
      c.update_column(:rating_count, c.course_ratings.count)
      c.update_column(:rating_points, c.course_ratings.sum(:points))
    end
  end
end
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cate1 = Category.create(name: 'Luyện thi Toeic')
CourseLevel.create(level: 1, name: '185 – 250', description: 'Beginner', category: cate1)
CourseLevel.create(level: 2, name: '255 – 400', description: 'Elementary', category: cate1)
CourseLevel.create(level: 3, name: '405 – 600', description: 'Low Intermediate', category: cate1)
CourseLevel.create(level: 4, name: '605 – 780', description: 'Upper Intermediate', category: cate1)
CourseLevel.create(level: 5, name: '785 – 900', description: 'Low Advanced', category: cate1)
CourseLevel.create(level: 6, name: '905 - 990', description: 'Advanced', category: cate1)

cate2 = Category.create(name: 'Luyện thi IELTS')
CourseLevel.create(level: 1, name: '3.5 - 4.0', category: cate2)
CourseLevel.create(level: 2, name: '4.5 - 5.0', category: cate2)
CourseLevel.create(level: 3, name: '5.5 - 6.0', category: cate2)
CourseLevel.create(level: 4, name: '6.5 - 7.0', category: cate2)
CourseLevel.create(level: 5, name: '7.5 - 9.0', category: cate2)

cate3 = Category.create(name: 'Tiếng Anh Giao Tiếp')
CourseLevel.create(level: 1, name: 'Beginner', category: cate3)
CourseLevel.create(level: 2, name: 'Elementary', category: cate3)
CourseLevel.create(level: 3, name: 'Upper Elementary', category: cate3)
CourseLevel.create(level: 4, name: 'Intermediate', category: cate3)
CourseLevel.create(level: 5, name: 'Upper Intermediate', category: cate3)
CourseLevel.create(level: 6, name: 'Advanced', category: cate3)

cate4 = Category.create(name: 'Luyện thi THPT Quốc Gia')
Category.create(name: 'Toán', parent: cate4)
Category.create(name: 'Lý', parent: cate4)
Category.create(name: 'Hóa', parent: cate4)
Category.create(name: 'Anh Văn', parent: cate4)
Category.create(name: 'Ngữ Văn', parent: cate4)
Category.create(name: 'Sinh Học', parent: cate4)

CourseLevel.create(level: 1, name: 'Cơ Bản', category: cate4)
CourseLevel.create(level: 2, name: 'Trung Bình', category: cate4)
CourseLevel.create(level: 3, name: 'Nâng Cao', category: cate4)

cat5 = Category.create(name: 'Tiếng Nhật')
CourseLevel.create(level: 1, name: 'N5', category: cat5)
CourseLevel.create(level: 2, name: 'N4', category: cat5)
CourseLevel.create(level: 3, name: 'N3', category: cat5)
CourseLevel.create(level: 4, name: 'N2', category: cat5)
CourseLevel.create(level: 5, name: 'N1', category: cat5)

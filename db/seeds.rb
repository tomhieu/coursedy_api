# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
cate0 = Category.create(name: 'Ngoại ngữ')

cate1 = Category.create(name: 'Luyện thi Toeic', parent: cate0)
CourseLevel.create(level: 1, name: '185 – 250', description: 'Beginner', category: cate1)
CourseLevel.create(level: 2, name: '255 – 400', description: 'Elementary', category: cate1)
CourseLevel.create(level: 3, name: '405 – 600', description: 'Low Intermediate', category: cate1)
CourseLevel.create(level: 4, name: '605 – 780', description: 'Upper Intermediate', category: cate1)
CourseLevel.create(level: 5, name: '785 – 900', description: 'Low Advanced', category: cate1)
CourseLevel.create(level: 6, name: '905 - 990', description: 'Advanced', category: cate1)

cate2 = Category.create(name: 'Luyện thi IELTS', parent: cate0)
CourseLevel.create(level: 1, name: '3.5 - 4.0', category: cate2)
CourseLevel.create(level: 2, name: '4.5 - 5.0', category: cate2)
CourseLevel.create(level: 3, name: '5.5 - 6.0', category: cate2)
CourseLevel.create(level: 4, name: '6.5 - 7.0', category: cate2)
CourseLevel.create(level: 5, name: '7.5 - 9.0', category: cate2)

cate3 = Category.create(name: 'Tiếng Anh Giao Tiếp', parent: cate0)
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

cat5 = Category.create(name: 'Tiếng Nhật', parent: cate0)
CourseLevel.create(level: 1, name: 'N5', category: cat5)
CourseLevel.create(level: 2, name: 'N4', category: cat5)
CourseLevel.create(level: 3, name: 'N3', category: cat5)
CourseLevel.create(level: 4, name: 'N2', category: cat5)
CourseLevel.create(level: 5, name: 'N1', category: cat5)

districts = {
  "Quận 1" => "quan-1",
  "Quận 12" => "quan-12",
  "Quận Thủ Đức" => "thu-duc",
  "Quận 9" => "quan-9",
  "Quận Gò Vấp" => "go-vap",
  "Quận Bình Thạnh" => "binh-thanh",
  "Quận Tân Bình" => "tan-binh",
  "Quận Tân Phú" => "tan-phu",
  "Quận Phú Nhuận" => "phu-nhuan",
  "Quận 2" => "quan-2",
  "Quận 3" => "quan-3",
  "Quận 10" => "quan-10",
  "Quận 11" => "quan-11",
  "Quận 4" => "quan-4",
  "Quận 5" => "quan-5",
  "Quận 6" => "quan-6",
  "Quận 8" => "quan-8",
  "Quận Bình Tân" => "binh-tan",
  "Quận 7" => "quan-7",
  "Huyện Củ Chi" => "cu-chi",
  "Huyện Hóc Môn" => "hoc-mon",
  "Huyện Bình Chánh" => "binh-chanh",
  "Huyện Nhà Bè" => "nha-be",
  "Huyện Cần Giờ" => "can-gio"
}

CITIES = {
  # 1 => "Tp. Hồ Chí Minh",
  2 => "Hà Nội",
  3 => "Đà Nẵng",
  4 => "Hải Phòng",
  5 => "Cần Thơ"
}

city = City.create(name: "Hồ Chí Minh")

CITIES.values.each do |c|
  City.create(name: c)
end

districts.keys.each do |d|
  District.create(name: d, slug: districts[d], city_id: city.id)
end
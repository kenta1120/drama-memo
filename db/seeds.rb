# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
guest = User.find_or_create_by!(email: "guest@example.com") do |user|
  user.password = "guestpassword"
  user.name = "ゲストユーザー"
end

guest.avatar.attach(
  io: File.open(Rails.root.join("app/assets/images/sample1.png")),
  filename: "sample1.png"
)

3.times do |i|
  guest.dramas.create!(
    title: "ゲストサンプルドラマ#{i + 1}",
    genre: "コメディ",
    mood: "癒し",
    description: "ゲストユーザーのサンプル投稿です。",
    is_public: true
  )
end

3.times do |i|
  user = User.create!(
    email: "sample#{i + 1}@example.com",
    password: "password",
    name: "サンプルユーザー#{i + 1}"
  )

  user.avatar.attach(
    io: File.open(Rails.root.join("app/assets/images/sample#{i + 1}.png")),
    filename: "sample#{i + 1}.png"
  )

  3.times do |j|
    user.dramas.create!(
      title: "サンプル#{i + 1}-ドラマ#{j + 1}",
      genre: "恋愛",
      mood: "胸キュン",
      description: "サンプルユーザー#{i + 1}の投稿です。",
      is_public: [true, false].sample
    )
  end
end

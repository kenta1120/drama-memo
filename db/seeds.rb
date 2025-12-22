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

guest.avatar.purge if guest.avatar.attached?
guest.avatar.attach(
  io: File.open(Rails.root.join("app/assets/images/sample1.png")),
  filename: "sample1.png"
)

3.times do |i|
  guest.dramas.find_or_create_by!(
    title: "ゲストサンプルドラマ#{i + 1}"
  ) do |drama|
    drama.genre = "コメディ"
    drama.mood = "癒し"
    drama.description = "ゲストユーザーのサンプル投稿です。"
    drama.is_public = true
  end
end

3.times do |i|
  user = User.find_or_create_by!(
    email: "sample#{i + 1}@example.com"
  ) do |u|
    u.password = "password"
    u.name = "サンプルユーザー#{i + 1}"
  end

  user.avatar.purge if user.avatar.attached?
  user.avatar.attach(
    io: File.open(Rails.root.join("app/assets/images/sample#{i + 1}.png")),
    filename: "sample#{i + 1}.png"
  )

  3.times do |j|
    user.dramas.find_or_create_by!(
      title: "サンプル#{i + 1}-ドラマ#{j + 1}"
    ) do |drama|
      drama.genre = "恋愛"
      drama.mood = "胸キュン"
      drama.description = "サンプルユーザー#{i + 1}の投稿です。"
      drama.is_public = [true, false].sample
    end
  end
end

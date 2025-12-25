# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def attach_avatar(user, filename, force: false)
  return if user.avatar.attached? && !force

  path = Rails.root.join("app/assets/images", filename)
  return unless File.exist?(path)

  user.avatar.purge if user.avatar.attached?

  user.avatar.attach(
    io: File.open(path),
    filename: filename,
    content_type: "image/png"
  )
end

drama_samples = [
  {
    title: "笑えるドラマ",
    genre: "コメディ",
    mood: "癒し"
  },
  {
    title: "怖すぎるドラマ",
    genre: "ホラー",
    mood: "怖い"
  },
  {
    title: "どきどきするドラマ",
    genre: "恋愛",
    mood: "ドキドキ"
  }
]

# ゲストユーザー
guest = User.find_or_create_by!(email: "guest@example.com") do |u|
  u.password = "guestpassword"
  u.name = "ゲストユーザー"
end

attach_avatar(guest, "sample1.png", force: true)
guest.dramas.destroy_all

drama_samples.each do |sample|
  guest.dramas.create!(
    title: sample[:title],
    genre: sample[:genre],
    mood: sample[:mood],
    description: "ゲストユーザーのサンプル投稿です。",
    is_public: true
  )
end

# サンプルユーザー
sample_users = [
  {
    email: "sample1@example.com",
    name: "サンプルユーザー1",
    password: "password",
    avatar: "sample2.png"
  },
    {
    email: "sample2@example.com",
    name: "サンプルユーザー2",
    password: "password",
    avatar: "sample3.png"
  },
    {
    email: "sample3@example.com",
    name: "サンプルユーザー3",
    password: "password",
    avatar: "sample4.png"
  }
]

sample_users.each do |data|
  user = User.find_or_create_by!(email: data[:email]) do |u|
    u.password = "password"
    u.name = data[:name]
  end

  attach_avatar(user, data[:avatar], force: true)
  user.dramas.destroy_all

  drama_samples.each do |sample|
    user.dramas.create!(
      title: sample[:title],
      genre: sample[:genre],
      mood: sample[:mood],
      description: "#{user.name}のサンプル投稿です。",
      is_public: true
    )
  end
end

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

# サムネ付与
def attach_thumbnail(drama, filename, force: false)
  return if drama.thumbnail.attached? && !force

  path = Rails.root.join("app/assets/images/seed_thumbs", filename)
  return unless File.exist?(path)

  drama.thumbnail.purge if drama.thumbnail.attached?

  drama.thumbnail.attach(
    io: File.open(path),
    filename: filename,
    content_type: "image/png"
  )
end

drama_samples = [
  {
    title: "青空のしたの青春",
    genre: "恋愛",
    mood: "癒し",
    scene: "ほっとしたい時",
    watched_on: Date.new(2025, 6, 20),
    description: "懐かしさも感じられ、明るくなれる作品。",
    is_public: true,
    thumbnail: "thumb_01.png"
  },
  {
    title: "噂のホテル",
    genre: "ホラー",
    mood: "怖い",
    scene: "一人の夜は注意",
    watched_on: Date.new(2025, 7, 3),
    description: "クライマックスに近づくにつれて、怖さ増します。",
    is_public: true,
    thumbnail: "thumb_02.png"
  },
  {
    title: "最弱のスーパーマン",
    genre: "コメディ",
    mood: "感動",
    scene: "笑いも感動も欲してる時",
    watched_on: Date.new(2025, 8, 15),
    description: "弱すぎるヒーローが全てをかけて街を救う物語。",
    is_public: false,
    thumbnail: "thumb_03.png"
  },
  {
    title: "防犯カメラの盲点",
    genre: "サスペンス",
    mood: "ドキドキ",
    scene: "集中力がある夜",
    watched_on: Date.new(2025, 9, 5),
    description: "防犯カメラがある犯行現場で、何も写っていない違和感その謎に迫る。",
    is_public: false,
    thumbnail: "thumb_04.png"
  },
  {
    title: "窓の外に立つ影",
    genre: "ホラー",
    mood: "怖い",
    scene: "ゾクッとしたい夏の夜など",
    watched_on: Date.new(2025, 10, 2),
    description: "毎晩同じ時間に、窓の外に誰かが立っている。",
    is_public: true,
    thumbnail: "thumb_05.png"
  },
  {
    title: "眠らない森",
    genre: "ファンタジー",
    mood: "癒し",
    scene: "世界観に浸りたいとき",
    watched_on: Date.new(2025, 11, 3),
    description: "孤独感を感じた時に、その森に入ると楽しい気持ちになれる不思議な物語。",
    is_public: false,
    thumbnail: "thumb_06.png"
  },
  {
    title: "帰還不能区域",
    genre: "アクション",
    mood: "ドキドキ",
    scene: "ドキドキ、ワクワクしたいとき",
    watched_on: Date.new(2025, 11, 20),
    description: "地図にない区域で特殊部隊が任務を遂行していく。",
    is_public: true,
    thumbnail: "thumb_07.png"
  },
  {
    title: "鍵のない扉",
    genre: "ファンタジー",
    mood: "癒し",
    scene: "考察したい時",
    watched_on: Date.new(2025, 12, 5),
    description: "毎日決まった時間に、鍵のない扉が現れ、不思議な世界へ誘う。",
    is_public: false,
    thumbnail: "thumb_08.png"
  },
  {
    title: "告白までの七日間",
    genre: "恋愛",
    mood: "胸キュン",
    scene: "恋愛もの見たいとき",
    watched_on: Date.new(2025, 12, 25),
    description: "告白までの7日間何度もやり直し、小さな選択で関係が変わる。",
    is_public: true,
    thumbnail: "thumb_09.png"
  },
  {
    title: "逃げ場のない街",
    genre: "アクション",
    mood: "ドキドキ",
    scene: "ハラハラしたい時",
    watched_on: Date.new(2025, 12, 28),
    description: "出入口が封鎖された街で始まる逃走劇。",
    is_public: false,
    thumbnail: "thumb_10.png"
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
  drama = guest.dramas.create!(
    title: sample[:title],
    genre: sample[:genre],
    mood: sample[:mood],
    scene: sample[:scene],
    watched_on: sample[:watched_on],
    description: sample[:description],
    is_public: sample[:is_public]
  )

  attach_thumbnail(drama, sample[:thumbnail], force: true)
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
    drama = user.dramas.create!(
      title: sample[:title],
      genre: sample[:genre],
      mood: sample[:mood],
      scene: sample[:scene],
      watched_on: sample[:watched_on],
      description: "#{user.name}のコメント：#{sample[:description]}",
      is_public: sample[:is_public]
    )

    attach_thumbnail(drama, sample[:thumbnail], force: true)
  end
end

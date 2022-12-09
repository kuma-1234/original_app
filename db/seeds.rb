users = [
  User.create(
    name: "高木", 
    email: "abc@example.com", 
    password: "pas123456",
    # icon: File.open("./app/assets/images/")
  ),
  User.create(
    name: "安室", 
    email: "def@example.com",
    password: "pas123456",
    # icon:
  ),
  User.create(
    name: "服部", 
    email: "ghi@example.com", 
    password: "pas123456",
    # icon:
  ),
  User.create(
    name: "江戸川", 
    email: "jkl@example.com", 
    password: "pas123456",
    # icon:
  ),
  User.create(
    name: "灰原", 
    email: "mno@example.com", 
    password: "pas123456",
    # icon:
  )
]

users.each do |user|
  profile = user.build_profile
  prefecture = '北海道'
  user.profile.update!(
    prefecture: prefecture,
  )
end

Drone.create!([
  {profile_id: 1, drone_name:'MG-1'},
  {profile_id: 2, drone_name:'T30'},
  {profile_id: 3, drone_name:'購入検討中'},
  {profile_id: 4, drone_name:'MG-1K'},
  {profile_id: 5, drone_name:'飛助'}
])


User.find(1).profile.update!(
  prefecture: '秋田県',
  main_crop:'米',
  self_introduce: 'はじめまして！秋田で農業をやっている高木です。ドローン初心者です。宜しくお願いします。',
)

User.find(2).profile.update!(
  prefecture: '北海道',
  main_crop: 'じゃがいも・玉ねぎ・とうもろこし・米',
  self_introduce: '北海道でじゃがいもを主に作っている安室です！T30を使用して大規模圃場で作業しています！よろしくお願いします。'
)

User.find(3).profile.update!(
  prefecture: '埼玉県',
  main_crop: 'さといも・かぶ',
  self_introduce: '農業用ドローンの導入を検討しています。みなさんの日記を拝見して勉強したいと思います！'
)

User.find(4).profile.update!(
  prefecture: '新潟県',
  main_crop: '米・大豆・枝豆',
  self_introduce: '米農家です！ドローンは2018年から使用しています。自分の日記が誰かの役に立てたら嬉しいです！よろしくお願いします。'
)

User.find(5).profile.update!(
  prefecture: '茨城県',
  main_crop: 'れんこん・白菜・カリフラワー',
  self_introduce: '野菜を中心に生産しています。野菜にドローンを使用している人情報交換しましょう！よろしくお願いします。'
)

Blog.create!([
  {
    work_date: '2022-8-14',
    pesticide_type: '液剤',
    pesticide_name: '△△液剤',
    flight_speed: '18',
    crop: '稲',
    variety: 'コシヒカリ',
    spray_area: '2.0',
    content: '今年初めて散布する圃場◯◯に障害物があって散布が大変だった。',
    status: 'public',
    drone_ids: 4,
    user_id: 4
  },
  {
    work_date: '2022-6-17',
    pesticide_type: '粒剤',
    pesticide_name: '□□粒剤',
    flight_speed: '15',
    crop: '稲',
    variety: '新之助',
    rpm: '1200',
    shutter_opening: '16.5',
    spray_area: '3.0',
    content: '去年雑草が多かった場所の散布。（圃場□□）農薬ラベルに記載の方法だと、散布量が多かった。16.5%がこの剤はピッタリ！',
    status: 'public',
    drone_ids: 4,
    user_id: 4
  },
  {
    work_date: '2022-5-20',
    pesticide_type: '粒剤',
    pesticide_name: '□□粒剤',
    crop: 'れんこん',
    flight_speed: '15',
    rpm: '1200',
    shutter_opening:'16',
    spray_area: '0.5',
    content: '初れんこん散布。水が張っている上を飛ぶから緊張感がすごい。無事に終わって何より',
    status: 'public',
    drone_ids: 5,
    user_id: 5
  },
  {
    work_date: '2022-6-7',
    pesticide_type: '液剤',
    pesticide_name: '◯◯液剤',
    crop: '玉ねぎ',
    flight_speed: '20',
    spray_area: '0.8',
    content: 'ドローンで玉ねぎの防除を初めて実施。まだまだ手探り状態。他に良い方法があったら知りたい。',
    status: 'public',
    drone_ids: 2,
    user_id: 2
  },
  {
    work_date: '2022-7-7',
    pesticide_type: '粒剤（肥料）',
    pesticide_name: '穂肥',
    crop: '稲',
    variety: 'こしいぶき',
    flight_speed: '10',
    rpm: '800',
    shutter_opening: '100',
    spray_area: '0.8',
    content: '穂肥散布を実施！圃場に入らなくていいのはすごく楽。穂肥の粒が大きいからあまり落ちない。速度で調節してみた。他に何かいい方法あるかな？',
    status: 'public',
    drone_ids: 1,
    user_id: 1
  },
])

Comment.create!([
  {
    talk: '速度を遅くしすぎるよりも、時速15kmぐらいで2度撒きの方がいいですよ！満遍なく撒けるので',
    blog_id: 5,
    user_id: 4
  },
  {
    talk: 'そうなんですね！ありがとうございます。試してみたいと思います！',
    blog_id: 5,
    user_id: 1
  },
  {
    talk: 'れんこんにも散布できる剤があるんですね！初めて知りました',
    blog_id: 3,
    user_id: 3
  },
  {
    talk: '上空から均一に散布できるのでとても良かったですよ！',
    blog_id: 3,
    user_id: 5
  },
])

Favorite.create!([
  {user_id: 1, blog_id: 1},
  {user_id: 1, blog_id: 5},
  {user_id: 3, blog_id: 1},
  {user_id: 3, blog_id: 3},
  {user_id: 1, blog_id: 2},
  {user_id: 4, blog_id: 5},
  {user_id: 2, blog_id: 4},
  {user_id: 5, blog_id: 2},
])
# create_users(10)

# def create_users(quantity)
#   i = 0

#   quantity.times do
#     user_data = {
#       email: "user_#{i}@email.com",
#       password: 'testtest'
#     }

#     user = User.create!(user_data)
#     puts "User created with id #{user.id}"

#     i += 1
#   end
# end

author = User.first || User.create!(email: "user0@example.com", password: "testtest")
Post.find_or_create_by!(title: "Какой софт для трекинга при параллаксе?") do |p|
  p.body      = "Нужен совет по пайплайну (Nuke/AE, FBX и т.д.)."
end


puts "\n== Seeding Q&A (posts + comments) =="

author = User.find_by(email: "qa_author@example.com") ||
         User.create!(email: "qa_author@example.com", password: "testtest")

commenters = [
  ["qa_user1@example.com", "testtest"],
  ["qa_user2@example.com", "testtest"],
  ["qa_user3@example.com", "testtest"]
].map do |email, pwd|
  User.find_by(email: email) || User.create!(email: email, password: pwd)
end

questions = [
  {
    title: "Вопрос: Какой софт лучше для 3D-трекинга в шоте с параллаксом?",
    body:  "Сцена с handheld камерой, есть parallax. Думала о PFTrack/3DEqualizer. Нужен совет по пайплайну."
  },
  {
    title: "Вопрос: Чем матчить освещение для CG-объекта в съёмочном материале?",
    body:  "HDRI есть, но цветтемпература пляшет между дублями. Какие практики/ноды в Nuke используете?"
  },
  {
    title: "Вопрос: Чем лучше заменить keylight в AE для сложных волос?",
    body:  "Фон неравномерный, spill сильный. Стоит ли прыгать в Nuke, или хватит AE+pulgins?"
  }
]

# обновляем посты и комментарии
questions.each_with_index do |q, i|
  post = Post.find_or_initialize_by(title: q[:title])
  post.body = q[:body]
  post.save! unless post.persisted? && post.body == q[:body]

  # ответы
  thread = case i
  when 0
    [
      "Для параллакса берите 3DEqualizer. Если нет — PFTrack ок. Снимите много tracking-марок и метадату камеры.",
      "Ещё проверь rolling shutter — иногда спасает предварительная стабилизация/дисторсия линзы.",
    ]
  when 1
    [
      "HDRI норм, но сделайте grey/colour-chart на площадке, потом match-grade. В Nuke — C_DLUT + Grade по чарту.",
      "Посмотрите на ACES — сведёте несоответствия между дублями аккуратнее.",
    ]
  else
    [
      "Для сложных волос лучше Nuke: Primatte/Ultimatte+IBK. В AE можно Photokey + ручные маски, но больно.",
      "Spill убирайте по каналам, в Nuke — DespillMadness/Keymix.",
    ]
  end

  # создаём комментарии, если их ещё нет
  if post.comments.count < thread.size
    needed = thread.size - post.comments.count
    thread.last(needed).each_with_index do |text, j|
      user = commenters[(i + j) % commenters.size]
      post.comments.create!(body: text)
    end
  end

  puts "• Q&A пост: #{post.title} (#{post.comments.count} комм.)"
end

puts "Q&A seed\n"
# ============================================================================
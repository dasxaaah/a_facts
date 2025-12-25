puts "== Seeding started =="

QA_USERS = [
  "user0@example.com",
  "qa_author@example.com",
  "qa_user1@example.com",
  "qa_user2@example.com",
  "qa_user3@example.com"
]

QA_QUESTIONS = [
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
    body:  "Фон неравномерный, spill сильный. Стоит ли прыгать в Nuke, или хватит AE+plugins?"
  }
]

QA_THREADS = {
  0 => [
    "Для параллакса берите 3DEqualizer. Если нет - PFTrack тоже ок.",
    "Проверь rolling shutter. Иногда помогает стабилизация и lens distortion workflow."
  ],
  1 => [
    "Нужны grey/colour chart на площадке. Потом match-grade по чарту.",
    "Если используете ACES, сводить разные дубли обычно проще."
  ],
  2 => [
    "Для волос удобнее Nuke: IBK + Keyer, и потом ручная доводка.",
    "Spill убирайте отдельно, часто проще через Keymix + despill."
  ]
}

ARTICLES_DATA = [
  {
    title: "Как работает зелёный экран: от съёмки до композита",
    body:  "Green screen это система: свет, clean plate, spill контроль и корректная работа keyer-ноды.",
    category: "технологии"
  },
  {
    title: "Почему 3DEqualizer считается стандартом для трекинга камеры",
    body:  "3DE даёт точную калибровку камеры, работу с lens distortion и стабильный solve в сложных шотах.",
    category: "разборы"
  }
]

TUTORIALS_DATA = [
  {
    title: "Туториал: первый композитинг шот в Nuke",
    body:  "Базовый сетап: Read, Grade, Merge, Keyer, маски, организация нод."
  },
  {
    title: "Туториал: базовая симуляция дыма в Houdini",
    body:  "Pyro Solver, эмиттер, параметры плотности, быстрый preview и экспорт."
  }
]

def seed
  create_base_users
  create_admin_user

  seed_posts_with_comments
  seed_articles_and_tutorials


  puts "== Seeding finished =="
end

def create_base_users
  QA_USERS.each do |email|
    user = User.find_or_initialize_by(email: email)
    user.password = "1234qwer"
    user.password_confirmation = "1234qwer" if user.respond_to?(:password_confirmation=)
    user.save!
    puts "User: #{user.email} (id=#{user.id})"
  end
end

def create_admin_user
  admin = User.find_or_create_by!(email: "admin@email.com") do |u|
    u.password = "testtest"
  end

  if admin.respond_to?(:admin=)
    admin.update!(admin: true)
  end

  puts "Admin: #{admin.email} (id=#{admin.id})"
end

def upload_random_post_image
  path = Dir.glob(Rails.root.join("public/autoupload/posts/*")).sample
  return nil unless path

  uploader = PostImageUploader.new(Post.new, :post_image)
  uploader.cache!(File.open(path))
  uploader
end

def seed_posts_with_comments
  puts "== Seeding Posts (Q&A) =="

  author = User.find_by(email: "qa_author@example.com") || User.first
  commenters = User.where(email: ["qa_user1@example.com", "qa_user2@example.com", "qa_user3@example.com"]).to_a

  QA_QUESTIONS.each_with_index do |q, index|
    post = Post.create!(
      title: q[:title],
      body:  q[:body],
      user:  author,
      post_image: upload_random_post_image
    )

    thread_texts = QA_THREADS[index] || []
    thread_texts.each_with_index do |text, j|
      user = commenters[(post.id + j) % commenters.size] rescue author
      Comment.create!(post: post, user: user, body: text)
    end

    puts "Post: #{post.title} (comments=#{post.comments.count}, image=#{post.post_image.present?})"
  end
end

def seed_articles_and_tutorials
  puts "== Seeding Articles and Tutorials =="

  admin = admin_user

  ARTICLES_DATA.each do |data|
    a = Article.create!(
      title: data[:title],
      body: data[:body],
      category: data[:category],    
    )
    puts "Article: #{a.title}"
  end

  TUTORIALS_DATA.each do |data|
    t = Tutorial.create!(
      title: data[:title],
      body: data[:body],
    )
    puts "Tutorial: #{t.title}"
  end
end


seed
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
    "Для параллакса берите 3DEqualizer. Если нет - PFTrack ок. Снимите много tracking-марок и метадату камеры.",
    "Ещё проверь rolling shutter - иногда спасает предварительная стабилизация/дисторсия линзы."
  ],
  1 => [
    "HDRI норм, но сделайте grey/colour-chart на площадке, потом match-grade. В Nuke - C_DLUT + Grade по чарту.",
    "Посмотрите на ACES - сведёте несоответствия между дублями аккуратнее."
  ],
  2 => [
    "Для сложных волос лучше Nuke: Primatte/Ultimatte+IBK. В AE можно Photokey + ручные маски, но больно.",
    "Spill убирайте по каналам, в Nuke - DespillMadness/Keymix."
  ]
}

ARTICLES_DATA = [
  {
    title: "Как работает зелёный экран: от съёмки до композита",
    body:  "Green screen это не просто фон, а система: свет, clean plate, spill контроль и корректная работа keyer нодами. В статье разбирается путь от съёмки до финального композита."
  },
  {
    title: "Почему 3DEqualizer считается стандартом для трекинга камеры",
    body:  "3DE даёт точную калибровку камеры, работу с lens distortion и стабильный solve для сложных шотов с параллаксом. Объясняем, почему его выбирают крупные студии."
  },
  {
    title: "Как устроен пайплайн современного VFX проекта",
    body:  "Matchmove, layout, assets, animation, FX, lighting, compositing и DI. Показываем, как департаменты собираются в единый пайплайн и почему это критично для качества."
  }
]

TUTORIALS_DATA = [
  {
    title: "Туториал: первый композитинг шот в Nuke",
    body:  "Разбираем базовый сетап: Read, Grade, Merge, Keyer, маски, организацию нод и Viewer Input Processing на простом шоте."
  },
  {
    title: "Туториал: параллакс в After Effects из одной картинки",
    body:  "Готовим слои в Photoshop, импортируем в AE, настраиваем трёхмерную сцену и анимацию камеры с контролем глубины."
  },
  {
    title: "Туториал: базовая симуляция дыма в Houdini",
    body:  "Pyro Solver, эмиттер, параметры плотности и температуры, быстрый превью рендер и экспорт для композита."
  }
]

def seed
  create_base_users
  seed_example_post
  seed_qa_threads
  seed_articles_and_tutorials
  puts "== Seeding finished =="
end

def create_base_users
  QA_USERS.each do |email|
    user = User.find_or_create_by!(email: email) do |u|
      u.password = "testtest"
    end
    puts "User: #{user.email} (id=#{user.id})"
  end
end

def seed_example_post
  author = User.find_by(email: "user0@example.com")

  post = author.posts.find_or_create_by!(title: "Какой софт для трекинга при параллаксе?") do |p|
    p.body = "Нужен совет по пайплайну (Nuke/AE, FBX и т.д.)."
  end

  puts "Example post: #{post.title} (id=#{post.id})"
end

def seed_qa_threads
  puts "\n== Seeding Q&A (posts + comments) =="

  author = User.find_by(email: "qa_author@example.com")
  commenters = User.where(email: ["qa_user1@example.com", "qa_user2@example.com", "qa_user3@example.com"]).to_a

  QA_QUESTIONS.each_with_index do |q, index|
    post = author.posts.find_or_create_by!(title: q[:title]) do |p|
      p.body = q[:body]
    end

    thread = QA_THREADS[index] || []
    ensure_comments_for_post(post, thread, commenters)

    puts "• Q&A пост: #{post.title} (#{post.comments.count} комментариев)"
  end

  puts "Q&A seed done\n"
end

def seed_articles_and_tutorials
  puts "\n== Seeding Articles and Tutorials =="

  author = User.find_by(email: "qa_author@example.com") || User.first

  # статьи
  ARTICLES_DATA.each do |data|
    article = Article.find_or_create_by!(title: data[:title]) do |a|
      a.body = data[:body]
      # enum: article_type: { article: ..., tutorial: ... }
      a.article_type = :article if a.respond_to?(:article_type=)
      a.user         = author if a.respond_to?(:user=)
    end

    puts "Article: #{article.title} (id=#{article.id})"
  end

  # туториалы
  TUTORIALS_DATA.each do |data|
    tutorial = Article.find_or_create_by!(title: data[:title]) do |a|
      a.body = data[:body]
      a.article_type = :tutorial if a.respond_to?(:article_type=)
      a.user         = author if a.respond_to?(:user=)
    end

    puts "Tutorial: #{tutorial.title} (id=#{tutorial.id})"
  end

  puts "Articles and tutorials seed done\n"
end

def ensure_comments_for_post(post, texts, commenters)
  existing_count = post.comments.count
  needed = texts.size - existing_count
  return if needed <= 0

  texts.last(needed).each_with_index do |text, j|
    user = commenters[(post.id + j) % commenters.size] if commenters.any?

    comment_data = { body: text }
    comment_data[:user] = user if post.comments.build.respond_to?(:user)

    post.comments.create!(comment_data)
  end
end

seed
puts "== Seeding started =="

QA_USERS = [
  "user1@gmail.com",
  "user2@gmail.com",
  "user3@gmail.com",
  "user4@gmail.com",
  "user5@gmail.com"
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
    title: "За кулисами: сцены из  «Безумного Макса»",
    category: "Разборы",
    cover: "article_cover_1.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что такое motion capture",
    category: "Технологии",
    cover: "article_cover_2.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "VFX разбор: плащ Доктора Стрэнджа",
    category: "Личности",
    cover: "article_cover_3.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Как работает 3D-сканирование",
    category: "Подборки",
    cover: "article_cover_4.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что такое motion capture ",
    category: "Технологии",
    cover: "article_cover_5.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что такое motion capture ",
    category: "Технологии",
    cover: "article_cover_1.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Чо такое motion capture ",
    category: "Технологии",
    cover: "article_cover_2.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что таке motion capture ",
    category: "Технологии",
    cover: "article_cover_3.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что такое motio capture ",
    category: "Технологии",
    cover: "article_cover_4.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что такое motion capure ",
    category: "Технологии",
    cover: "article_cover_5.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },{
    title: "За кулисами: сцены из  «Безумного Макса»",
    category: "Разборы",
    cover: "article_cover_1.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что такое motion capture",
    category: "Разборы",
    cover: "article_cover_2.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "VFX разбор: плащ Доктора Стрэнджа",
    category: "Личности",
    cover: "article_cover_3.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Как работает 3D-сканирование",
    category: "Технологии",
    cover: "article_cover_4.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что таое motion capture ",
    category: "Подборки",
    cover: "article_cover_5.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что такое motion captre ",
    category: "Личности",
    cover: "article_cover_1.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Ч такое motion capture ",
    category: "Технологии",
    cover: "article_cover_2.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что так motion capture ",
    category: "Разборы",
    cover: "article_cover_3.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что такое moti capture ",
    category: "Личности",
    cover: "article_cover_4.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
  },
  {
    title: "Что такое motion capur ",
    category: "Подборка",
    cover: "article_cover_5.jpg",
    body: <<~HTML
      <p>Green screen — это система: свет, clean plate, контроль spill и грамотный key.</p>

      <h2 id="shooting">Съёмка</h2>
      <p>Ключевое — равномерный фон и separation от актёра.</p>

      <figure>
        <img src="/autoupload/articles/article_cover_2.jpg" alt="Схема света" />
        <figcaption>Пример сетапа света для хромакея</figcaption>
      </figure>

      <h2 id="comp">Композит</h2>
      <ul>
        <li>Подготовка plate</li>
        <li>Key</li>
        <li>Despill</li>
        <li>Matchgrade</li>
      </ul>
    HTML
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

GLOSSARY_TERMS_DATA = [
  {
    term: "Chromakey",
    category: "композитинг",
    definition: <<~TEXT
      Технология замены однотонного фона, чаще всего зелёного или синего,
      на другое изображение или видео.
    TEXT
  },
  {
    term: "Compositing",
    category: "композитинг",
    definition: <<~TEXT
      Процесс объединения нескольких визуальных слоёв в один финальный кадр.
    TEXT
  },
  {
    term: "Motion Capture",
    category: "технологии",
    definition: <<~TEXT
      Технология записи движения актёра для последующего переноса
      на цифрового персонажа.
    TEXT
  },
  {
    term: "Tracking",
    category: "технологии",
    definition: <<~TEXT
      Процесс анализа движения камеры или объекта в кадре,
      чтобы точно встроить CG-элементы.
    TEXT
  }
]

def seed
  create_base_users
  admin = create_admin_user

  seed_posts_with_comments
  seed_articles(admin)
  seed_tutorials(admin)
  seed_glossary_terms(admin)


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

# старый код
# def create_admin_user
#   admin = User.find_or_create_by!(email: "admin@email.com") do |u|
#     u.password = "testtest"
#   end

#   if admin.respond_to?(:admin=)
#     admin.update!(admin: true)
#   end

#   puts "Admin: #{admin.email} (id=#{admin.id})"
# end

def create_admin_user
  admin = User.find_or_create_by!(email: "admin@email.com") do |u|
    u.password = "testtest"
  end

  admin.update!(admin: true) if admin.respond_to?(:admin=)

  puts "Admin: #{admin.email} (id=#{admin.id})"
  admin
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

  author = User.find_by(email: "user1@gmail.com") || User.first
  commenters = User.where(email: ["user2@gmail.com", "user3@gmail.com", "user4@gmail.com", "user5@gmail.com"]).to_a

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


def file_from_public(*parts)
  path = Rails.root.join("public", *parts)
  return nil unless File.exist?(path)
  File.open(path)
end

def seed_articles(admin)
  puts "== Seeding Articles =="

  ARTICLES_DATA.each do |data|
    a = Article.find_or_initialize_by(title: data[:title])
    a.body = data[:body]
    a.category = data[:category]
    a.user_id = admin.id

    if data[:cover].present?
      cover_file = file_from_public("autoupload", "articles", data[:cover])
      if cover_file
        a.cover_image = cover_file
      else
        puts "WARNING: Article cover not found: public/autoupload/articles/#{data[:cover]}"
      end
    end

    a.save!
    puts "Article: #{a.title} (cover=#{a.cover_image.present?})"
  end
end

def seed_tutorials(admin)
  puts "== Seeding Tutorials =="

  TUTORIALS_DATA.each do |data|
    t = Tutorial.find_or_initialize_by(title: data[:title])
    t.body = data[:body]
    t.user_id = admin.id if t.respond_to?(:user_id=)

    if t.respond_to?(:cover_image=) && data[:cover].present?
      cover_file = file_from_public("autoupload", "tutorials", data[:cover])
      if cover_file
        t.cover_image = cover_file
      else
        puts "WARNING: Tutorial cover not found: public/autoupload/tutorials/#{data[:cover]}"
      end
    end

    t.save!
    puts "Tutorial: #{t.title}"
  end
end

def seed_glossary_terms(admin)
  puts "== Seeding Glossary Terms =="

  GLOSSARY_TERMS_DATA.each do |data|
    term = GlossaryTerm.find_or_initialize_by(term: data[:term])

    term.definition = data[:definition]
    term.category = data[:category]
    term.user_id = admin.id if term.respond_to?(:user_id=)

    term.save!
    puts "Glossary term: #{term.term}"
  end
end

seed
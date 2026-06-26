module GlossaryTermsHelper
  GLOSSARY_TERM_MEDIA_IMAGES = [
    "/autoupload/lessons/lesson_cover_5.jpg",
    "/autoupload/lessons/lesson_cover_6.jpg",
    "/autoupload/lessons/lesson_cover_7.jpg",
    "/autoupload/lessons/lesson_cover_8.jpg",
    "/autoupload/lessons/lesson_cover_9.jpg",
    "/autoupload/lessons/lesson_cover_10.jpg",
    "/autoupload/lessons/lesson_cover_11.jpg",
    "/autoupload/lessons/lesson_cover_12.jpg",
    "/autoupload/lessons/lesson_cover_13.jpg",
    "/autoupload/lessons/lesson_cover_14.jpg",
    "/autoupload/lessons/lesson_cover_15.jpg",
    "/autoupload/lessons/lesson_cover_16.jpg"
  ].freeze

  def glossary_term_media_image(term)
    index = term.to_param.to_i
    index = term.term.to_s.each_byte.sum if index.zero?

    GLOSSARY_TERM_MEDIA_IMAGES[index % GLOSSARY_TERM_MEDIA_IMAGES.length]
  end
end

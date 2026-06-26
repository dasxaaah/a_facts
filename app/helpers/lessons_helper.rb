module LessonsHelper
  def rutube_embed_url(video_url)
    video_id = video_url.to_s[%r{rutube\.ru/video/([^/?#]+)}, 1]
    return if video_id.blank?

    "https://rutube.ru/play/embed/#{video_id}"
  end

  def grouped_lesson_body(body)
    sanitized_body = sanitize(body.to_s)
    fragment = Nokogiri::HTML.fragment(sanitized_body)

    fragment.css("h2").each do |heading|
      next if heading.ancestors(".lesson_text_block").any?

      block_nodes = [heading]
      next_node = heading.next_element

      while next_node&.name == "p" && block_nodes.count < 4
        block_nodes << next_node
        next_node = next_node.next_element
      end

      next if block_nodes.count == 1

      wrapper = Nokogiri::XML::Node.new("div", fragment)
      wrapper["class"] = "lesson_text_block"
      heading.add_previous_sibling(wrapper)
      block_nodes.each { |node| wrapper.add_child(node) }
    end

    fragment.to_html.html_safe
  end
end

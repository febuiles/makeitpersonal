require 'redcarpet'

class MarkdownRenderer
  def initialize
    @renderer = Redcarpet::Render::HTML.new(filter_html: true)
    @markdown = Redcarpet::Markdown.new(@renderer, :autolink => true, :space_after_headers => true)
  end

  def render(content)
    @markdown.render(content)
  end
end

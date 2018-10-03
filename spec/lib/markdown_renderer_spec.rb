require_relative "../../lib/markdown_renderer"

describe MarkdownRenderer do
  describe "#render" do
    let(:renderer) { MarkdownRenderer.new }

    it "converts Markdown to HTML" do
      expect(renderer.render("*testing*")).to eq("<p><em>testing</em></p>\n")
    end
  end
end

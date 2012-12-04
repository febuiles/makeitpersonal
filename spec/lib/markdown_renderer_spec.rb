require_relative "../../lib/markdown_renderer"

describe MarkdownRenderer do
  describe "#render" do
    let(:renderer) { MarkdownRenderer.new }

    it "converts Markdown to HTML" do
      renderer.render("*testing*").should == "<p><em>testing</em></p>\n"
    end
  end
end

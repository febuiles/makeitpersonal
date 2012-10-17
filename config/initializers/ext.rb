class String
  def to_key
    self.strip.downcase.gsub(/ /, "-").gsub(/\./, "")
  end

  def from_key
    self.strip.downcase.gsub(/-/, " ")
  end

  def replace_newlines
    gsub!("\n", "<br/>").html_safe
  end
end

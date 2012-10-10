module ApplicationHelper
  def title(title)
    content_for(:title) { title }
  end

  def random_greeting_for_user
    user = "<span class=\"green\">#{ current_user.username }</span>"
    greetings = ["Hey #{user}, long time no see!",
                 "Welcome back #{user}.",
                 "Hola #{user}.",
                 "Hey #{user}, how\'s it going?",
                 "Buongiorno, Principessa, err... #{user}."]
    content_tag(:p, greetings.sample.html_safe)
  end
end

module ApplicationHelper
  def title(title)
    content_for(:title) { title }
  end

  def random_greeting_for_user
    user = "<span class=\"green\">#{ current_user.username }</span>"
    greetings = ["Hey #{user}, long time no see!",
                 "Welcome back #{user}.",
                 "Hola #{user}.",
                 "Hi #{user}. You look nice today.",
                 "Hey #{user}, how\'s it going?",
                 "Buongiorno, Principessa, err... #{user}.",
                 "Welcome back #{user}. We still think music can heal any wound.",
                 "Well, well, isn't this #{user}...",
                 "And on the third day #{user} came back.",
                 "Good ole #{user} is back in town.",
                 "omigod omigod omigod, #{user} is here!!!"
                ]
    content_tag(:p, greetings.sample.html_safe)
  end

  def random_sign_up_request
    sign_up = link_to("sign up", new_user_registration_path)
    learn_more = link_to("learn more", "/manifesto")
    requests = ["makeitpersonal is super-duper-awesome, you should #{sign_up}! (or #{learn_more} about it).",
                "Hello there Mr. Guest, you can #{learn_more} about makeitpersonal or go #{sign_up}!",
                "Roses are red, violets are blue, makeitpersonal is oh-so-good for you (#{learn_more.capitalize})."
               ]
    content_tag(:p, requests.sample.html_safe)
  end
end

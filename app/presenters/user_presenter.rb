require 'digest/md5'

module UserPresenter
  def display_name
    if name.present?
      "#{ name } (#{ username })"
    else
      username
    end
  end

  def gravatar
    hash = Digest::MD5.hexdigest(email.downcase)
    "<img class='avatar' src='http://www.gravatar.com/avatar/#{hash}?d=mm&s=80' />".html_safe
  end

  def blank_profile?
    [:twitter, :website, :name, :bio].each do |field|
      return false if send(field).present?
    end
    true
  end
end

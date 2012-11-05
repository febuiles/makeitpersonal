module UserPresenter
  def display_name
    if name.present?
      "#{ name } (#{ username })"
    else
      username
    end
  end
end

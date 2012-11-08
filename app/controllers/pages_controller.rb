class PagesController < ApplicationController
  layout 'landing'

  def index
    if current_user
      redirect_to account_path
    else
      mixpanel.append_track "Visits Landing"
    end
  end

  def manifesto
    render :index
  end

  def disclaimer; end
  def credits; end
  def contacts; end
end

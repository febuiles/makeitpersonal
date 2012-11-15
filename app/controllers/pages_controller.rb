class PagesController < ApplicationController
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

  def contact_form
    NotificationsMailer.contact(params[:name], params[:email], params[:message]).deliver
    redirect_to "/contact", :notice => "Thanks. We'll reply if necessary as soon as possible"
  end
end

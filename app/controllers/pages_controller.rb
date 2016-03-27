class PagesController < ApplicationController
  def index
    redirect_to account_path if current_user
  end

  def manifesto
    render :index
  end

  def contact_form
    NotificationsMailer.contact(params[:name], params[:email], params[:message]).deliver
    redirect_to "/contact", :notice => "Thanks. We'll reply if necessary as soon as possible"
  end
end

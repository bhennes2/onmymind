class FriendMailer < ActionMailer::Base
  default :from => "notifications@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.friend_mailer.request.subject
  #
  def welcome(user, current_user, relationship_id, root_url)
	@user = user
	@current_user = current_user
	@root_url = root_url
	@url  = root_url + "acceptance?id=" + relationship_id.to_s()
    	mail(:to => @user.email, :subject => "OMM Friend Request")
  end
end

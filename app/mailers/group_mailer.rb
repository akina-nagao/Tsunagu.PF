class GroupMailer < ApplicationMailer
  def send_group_members(post, title, message, member)
    @post = post
    @title = title
    @message = message
    @member = member
    mail to: @member.email, subject: "#{@post}.title"
  end
end

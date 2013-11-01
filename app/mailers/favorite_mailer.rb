class FavoriteMailer < ActionMailer::Base
  default from: "serixscorpio@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    # New Headers
    headers["Message-ID"] = "<comments/#{@comment.id}@eric-bloccit.example>"
    headers["In-Reply-To"] = "<post/#{@post.id}@eric-bloccit.example>"
    headers["References"] = "<post/#{@post.id}@eric-bloccit.example>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end

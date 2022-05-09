# To deliver this notification:
#
# QuizNotification.with(post: @post).deliver_later(current_user)
# QuizNotification.with(post: @post).deliver(current_user)

class QuizNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    @user = params[:user]
    "#{@user.email} played a quiz"
  end

  def url
    quiz_path(params[:quiz])
  end
end

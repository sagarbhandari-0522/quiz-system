# frozen_string_literal: true

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
    @email = params[:email]
    "#{@email} has performed a quiz"
  end

  def url
    quiz_path(Quiz.find(params[:quiz][:id]))
  end
end

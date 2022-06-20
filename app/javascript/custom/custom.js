
function user_quiz(user_id) {
  jQuery.ajax({
    url: "/user_quizzes",
    type: "GET",
    data: { "user_id": user_id },
    dateType: 'html'

  })
}

function user_quiz(user_id) {
  jQuery.ajax({
    url: "/user_quizzes",
    type: "GET",
    data: { "user_id": user_id },
    dateType: 'html'

  })
}
const form = document.getElementById('new_quiz')
const time = document.getElementById('clock')
const padZero = (number = 0, requiredLength = 2) => {
  const currentLength = number.toString().length;
  const neededToPadLength = requiredLength - currentLength;

  return neededToPadLength > 0 ? `${'0'.repeat(neededToPadLength)}${number}` : number;
};

let min = 1, sec = 0
const timeoutId = setInterval(() => {
  if (sec === 0) { min--; sec = 59; }
  time.innerHTML = `TIME: ${padZero(min)} : ${padZero(sec - 1)}`

  sec--

  if (min === 0 && sec === 0) {
    form.submit();
    clearInterval(timeoutId)
    alert('Time exceded ')
  }
}, 1000)
document.addEventListener('turbolinks:load', function() {
  var timer = document.querySelector('.timer');

  if (timer) { updateTimer(timer); }
});

function updateTimer(timer) {
  if (sessionStorage.getItem('timeLeft') == null) {
    
  }
  sessionStorage.setItem('timeLeft', timer.getAttribute('data-test-time') * 60);
  timeLeft = sessionStorage.getItem('timeLeft');
  console.log(timeLeft);

  var timerId = setInterval(function() {
    timeLeft -= 1;

    if (timeLeft <= 0) {
      sessionStorage.clear();
      clearInterval(timerId);
      document.querySelector('.form').submit();
    }

    displayTime(timer, timeLeft);
    sessionStorage.setItem('timeLeft', timeLeft);
  }, 1000);
}

function displayTime(timer, timeLeft) {
  // console.log(timeLeft);
  var minutesLeft = Math.trunc(timeLeft / 60);
  var secondsLeft = timeLeft % 60;
  
  timer.textContent = minutesLeft + ' : ' + secondsLeft;
}
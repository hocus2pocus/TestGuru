document.addEventListener('turbolinks:load', function(){
  var control = document.querySelector('.timer');
  if (control) { timer(control) };

  function timer(control) {
    var limit = control.dataset.limit;
    if(limit > 0) { control.classList.remove('hide') }

    var now = Date.now();
    var then = now + limit * 1000;

    setInterval(() => {
      var timeLeft = Math.round((then - Date.now()) / 1000);

      if(timeLeft <= 0) {
        clearInterval();
        alarm();
        return;
      }
      displayTime(timeLeft);
    }, 1000)
  };


  function displayTime(seconds) {
    var endMinutes = Math.floor(seconds / 60);
    var endSeconds = seconds % 60;

    control.innerHTML = `${endMinutes}:${endSeconds < 10 ? '0' : ''}${endSeconds}`;
  };

  function alarm() {
    var alarmTime = '00.00'
    control.classList.add('red-color');
    control.innerHTML = `${alarmTime}`;
  };
})

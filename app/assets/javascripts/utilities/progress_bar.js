document.addEventListener('turbolinks:load', function(){
  var control = document.querySelector('.progress-bar');
  if (control) {
    var percent = control.dataset.percent;
    control.style.width = percent + "%";
  }
})


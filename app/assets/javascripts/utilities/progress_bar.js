document.addEventListener('turbolinks:load', function(){
  let control = document.querySelector('.progress-bar')
  if (control) {
    let percent = control.dataset.percent
    control.style.width = percent + "%"
  }
})


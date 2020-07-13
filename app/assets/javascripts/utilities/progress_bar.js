document.addEventListener('turbolinks:load', function() {
  var bar = document.querySelector('.progress-bar');

  if (bar) {
    bar.style.width = bar.dataset.progress + '%';
  }
});
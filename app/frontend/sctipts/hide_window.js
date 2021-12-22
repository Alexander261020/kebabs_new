window.onload = function() {
  if (document.getElementById('btn-close') !== null) {
    document.getElementById('btn-close').addEventListener('click', function () {
      document.getElementById('win-message').style.display = 'none';
    });
  }
};

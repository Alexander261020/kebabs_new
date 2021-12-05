window.onload = function() {
  let close = document.getElementById("btn-close")
  close.addEventListener("click", function () {
    let win = document.getElementById("win-message");
    win.style.display = "none";
  });
};

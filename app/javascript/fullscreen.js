function FullScreen() {
  const Look = document.getElementById("look");
  const Test = document.getElementById("a");
  Look.addEventListener("click", () => {
    if (Test.requestFullscreen) {
      Test.requestFullscreen();
    } else if (Test.msRequestFullscreen) {
      Test.msRequestFullscreen();
    } else if (Test.mozRequestFullScreen) {
      Test.mozRequestFullScreen();
    } else if (Test.webkitRequestFullscreen) {
      Test.webkitRequestFullscreen();
    }
  });
}
window.addEventListener('load',FullScreen);
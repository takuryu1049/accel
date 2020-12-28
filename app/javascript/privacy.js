function Privacy() {
  const ToggleSwitch = document.getElementById('toggle-switch');
  const PrivacList = document.getElementById('privacy-list');
  const Hide = document.getElementById('hide');

  ToggleSwitch.addEventListener("click", () => {
    PrivacList.setAttribute("style", "opacity:1;");
    Hide.style.display="block";
    ToggleSwitch.style.display="none";
  });
  Hide.addEventListener("click", () => {
    PrivacList.setAttribute("style", "opacity:.3;");
    Hide.style.display="none";
    ToggleSwitch.style.display="block";
  });
  
}
window.addEventListener('load',Privacy);
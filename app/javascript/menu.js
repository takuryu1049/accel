function Menu() {
  const Humburger = document.getElementById('humburger');
  const Menu = document.getElementById('menu');
  const Close = document.getElementById('close');

  Humburger.addEventListener("click", () => {
    if (Menu.classList.contains("display-block")){
      Menu.classList.remove("display-block");
    }else{
      Menu.classList.add("display-block", "animate__animated","animate__bounceIn");
    }
  });

  Close.addEventListener("click", () => {
    Menu.classList.remove("display-block");
  });

}
window.addEventListener('load',Menu);
function Menu() {
  const Humburger = document.getElementById('humburger');
  const Menu = document.getElementById('menu');

  Humburger.addEventListener("click", () => {
    if (Menu.classList.contains("display-block")){
      Menu.classList.remove("menu-anime");
      Menu.classList.remove("display-block");
      Humburger.classList.remove("active");
    }else{
      Menu.classList.add("display-block", "menu-anime");
      Humburger.classList.add("active");
    }
  });

}
window.addEventListener('load',Menu);
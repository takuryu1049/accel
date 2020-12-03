if(location.pathname === "/"){
  function cursor() {
    const stalker = document.getElementById('cursor'); 

    //上記のdivタグをマウスに追従させる処理
    document.addEventListener('mousemove', function (e) {
        stalker.style.transform = 'translate(' + e.clientX + 'px, ' + e.clientY + 'px)';
    });
  }
  window.addEventListener('load',cursor);
}
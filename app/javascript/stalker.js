// if(location.pathname === "/"){
//   function cursor() {
//     const stalker = document.getElementById('cursor'); 

//     //上記のdivタグをマウスに追従させる処理
//     document.addEventListener('mousemove', function (e) {
//         stalker.style.transform = 'translate(' + e.clientX + 'px, ' + e.clientY + 'px)';
//     });
//   }
//   window.addEventListener('load',cursor);
// }

if(location.pathname === "/"){
  function cursor() {
    //マウスストーカー用のdivを取得
    const stalker = document.getElementById('cursor');

    //aタグにホバー中かどうかの判別フラグ
    let hovFlag = false;

    //マウスに追従させる処理 （リンクに吸い付いてる時は除外する）
    document.addEventListener('mousemove', function (e) {
        if (!hovFlag) {
        stalker.style.transform = 'translate(' + e.clientX + 'px, ' + e.clientY + 'px)';
        }
    });
    //リンクへ吸い付く処理
    const linkElem = document.querySelectorAll('a:not(.no_stick_)');
    for (let i = 0; i < linkElem.length; i++) {
        //マウスホバー時
        linkElem[i].addEventListener('mouseover', function (e) {
            hovFlag = true;

            //マウスストーカーにクラスをつける
            stalker.classList.add('hov_');

            //マウスストーカーの位置をリンクの中心に固定
            let rect = e.target.getBoundingClientRect();
            let posX = rect.left + (rect.width / 2);
            let posY = rect.top + (rect.height / 2);

            stalker.style.transform = 'translate(' + posX + 'px, ' + posY + 'px)';

        });
        //マウスホバー解除時
        linkElem[i].addEventListener('mouseout', function (e) {
            hovFlag = false;
            stalker.classList.remove('hov_');
        });
    }
  }
  window.addEventListener('load',cursor);
}
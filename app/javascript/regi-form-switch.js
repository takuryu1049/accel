// document.addEventListener('DOMContentLoaded', function(){
//   const CompanyName = document.getElementById('company-name');
//   console.log("読み込まれています");
// };
function RegiFormSwitch() {
  // 必要な要素を全て取得しておく。
  const HumanSwitch = document.getElementById('human-switch');
  const CompanySwitch = document.getElementById('company-switch');
  const OwnerCompanyName = document.getElementById('owner-company-name');
  const OwnerCompanyNameInput = document.getElementById('owner-company-name-input');
  const OwnerCompanyNameKana = document.getElementById('owner-company-name-kana');
  const OwnerCompanyNameKanaInput = document.getElementById('owner-company-name-kana-input');
  const OwnerLastName = document.getElementById('owner-last-name');
  const OwnerLastNameInput = document.getElementById('owner-last-name-input');
  const OwnerFirstName = document.getElementById('owner-first-name');
  const OwnerFirstNameInput = document.getElementById('owner-first-name-input');
  const OwnerLastNameKana = document.getElementById('owner-last-name-kana');
  const OwnerLastNameKanaInput = document.getElementById('owner-last-name-kana-input');
  const OwnerFirstNameKana = document.getElementById('owner-first-name-kana');
  const OwnerFirstNameKanaInput = document.getElementById('owner-first-name-kana-input');
  
  // エラーハンドリング後のレンダリング時に法人を選択していた場合に表示を切り替え
  if(CompanySwitch.checked == true){
    OwnerCompanyName.classList.remove('animate__animated',"animate__zoomOut","owner-company-name-none");
    OwnerCompanyNameKana.classList.remove('animate__animated',"animate__zoomOut","owner-company-name-kana-none");
    OwnerLastName.classList.add("owner-last-name-none");
    OwnerFirstName.classList.add("owner-first-name-none");
    OwnerLastNameKana.classList.add("owner-last-name-kana-none");
    OwnerFirstNameKana.classList.add("owner-first-name-kana-none");
  }

  // 個人ラジオボタンに変更された時の挙動
  HumanSwitch.addEventListener("change", () => {
    OwnerCompanyNameInput.value = "";
    OwnerCompanyName.classList.add('animate__animated',"animate__zoomOut");
    OwnerCompanyNameKanaInput.value = "";
    OwnerCompanyNameKana.classList.add('animate__animated',"animate__zoomOut");
    OwnerLastName.classList.remove('animate__animated',"animate__zoomOut","owner-last-name-none");
    OwnerFirstName.classList.remove('animate__animated',"animate__zoomOut","owner-first-name-none");
    OwnerLastNameKana .classList.remove('animate__animated',"animate__zoomOut","owner-last-name-kana-none");
    OwnerFirstNameKana .classList.remove('animate__animated',"animate__zoomOut","owner-first-name-kana-none");

    setTimeout(() => {
      OwnerCompanyName.classList.add("owner-company-name-none");
      OwnerCompanyNameKana.classList.add("owner-company-name-kana-none");
    }, 130)
  });

  // 法人ラジオボタンに変更された時の挙動
  CompanySwitch.addEventListener("change", () => {
    OwnerLastNameInput.value = "";
    OwnerLastName.classList.add('animate__animated',"animate__zoomOut");
    OwnerFirstNameInput.value = "";
    OwnerFirstName.classList.add('animate__animated',"animate__zoomOut");
    OwnerLastNameKanaInput.value = "";
    OwnerLastNameKana.classList.add('animate__animated',"animate__zoomOut");
    OwnerFirstNameKanaInput.value = "";
    OwnerFirstNameKana.classList.add('animate__animated',"animate__zoomOut");
    OwnerCompanyName.classList.remove('animate__animated',"animate__zoomOut","owner-company-name-none");
    OwnerCompanyNameKana.classList.remove('animate__animated',"animate__zoomOut","owner-company-name-kana-none");


    setTimeout(() => {
      OwnerLastName.classList.add("owner-last-name-none");
      OwnerFirstName.classList.add("owner-first-name-none");
      OwnerLastNameKana.classList.add("owner-last-name-kana-none");
      OwnerFirstNameKana.classList.add("owner-first-name-kana-none");
    }, 130)
  });
}
window.addEventListener('load',RegiFormSwitch);
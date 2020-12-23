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
  const Gender = document.getElementById('gender');
  const GenderInputMars = document.getElementById('gender-input-mars');
  const GenderInputVenus = document.getElementById('gender-input-venus');
  const Character = document.getElementById('character');
  const CharacterInput = document.getElementById('character-input');

  // エラーハンドリング後のレンダリング時に法人を選択していた場合に表示を切り替え
  if(CompanySwitch.checked == true){
    OwnerCompanyName.classList.remove('animate__animated',"animate__zoomOut","owner-company-name-none");
    OwnerCompanyNameKana.classList.remove('animate__animated',"animate__zoomOut","owner-company-name-kana-none");
    OwnerLastName.classList.add("owner-last-name-none");
    OwnerFirstName.classList.add("owner-first-name-none");
    OwnerLastNameKana.classList.add("owner-last-name-kana-none");
    OwnerFirstNameKana.classList.add("owner-first-name-kana-none");
    Gender.classList.add("gender-none");
    Character.classList.add("character-none");
  }

  // 個人ラジオボタンに変更された時の挙動
  HumanSwitch.addEventListener("change", () => {
    OwnerCompanyNameInput.value = "";
    // OwnerCompanyNameInput.setAttribute("disabled", true);
    OwnerCompanyName.classList.add('animate__animated',"animate__zoomOut");
    OwnerCompanyNameKanaInput.value = "";
    // OwnerCompanyNameKanaInput.setAttribute("disabled", true);
    OwnerCompanyNameKana.classList.add('animate__animated',"animate__zoomOut");
    OwnerLastName.classList.remove('animate__animated',"animate__zoomOut","owner-last-name-none");
    OwnerFirstName.classList.remove('animate__animated',"animate__zoomOut","owner-first-name-none");
    OwnerLastNameKana.classList.remove('animate__animated',"animate__zoomOut","owner-last-name-kana-none");
    OwnerFirstNameKana.classList.remove('animate__animated',"animate__zoomOut","owner-first-name-kana-none");
    Gender.classList.remove('animate__animated',"animate__zoomOut","gender-none");
    Character.classList.remove('animate__animated',"animate__zoomOut","character-none");

    setTimeout(() => {
      OwnerCompanyName.classList.add("owner-company-name-none");
      OwnerCompanyNameKana.classList.add("owner-company-name-kana-none");
    }, 130)
  });

  // 法人ラジオボタンに変更された時の挙動
  CompanySwitch.addEventListener("change", () => {
    OwnerLastNameInput.value = "";
    // OwnerLastNameInput.setAttribute("disabled", true);
    OwnerLastName.classList.add('animate__animated',"animate__zoomOut");
    OwnerFirstNameInput.value = "";
    // OwnerFirstNameInput.setAttribute("disabled", true);
    OwnerFirstName.classList.add('animate__animated',"animate__zoomOut");
    OwnerLastNameKanaInput.value = "";
    // OwnerLastNameKanaInput.setAttribute("disabled", true);
    OwnerLastNameKana.classList.add('animate__animated',"animate__zoomOut");
    OwnerFirstNameKanaInput.value = "";
    // OwnerFirstNameKanaInput.setAttribute("disabled", true);
    OwnerFirstNameKana.classList.add('animate__animated',"animate__zoomOut");
    OwnerCompanyName.classList.remove('animate__animated',"animate__zoomOut","owner-company-name-none");
    OwnerCompanyNameKana.classList.remove('animate__animated',"animate__zoomOut","owner-company-name-kana-none");
    GenderInputMars.checked = "";
    GenderInputVenus.checked = "";
    Gender.classList.add('animate__animated',"animate__zoomOut");
    CharacterInput.value = "0";
    Character.classList.add('animate__animated',"animate__zoomOut");
    setTimeout(() => {
      OwnerLastName.classList.add("owner-last-name-none");
      OwnerFirstName.classList.add("owner-first-name-none");
      OwnerLastNameKana.classList.add("owner-last-name-kana-none");
      OwnerFirstNameKana.classList.add("owner-first-name-kana-none");
      OwnerFirstNameKana.classList.add("owner-first-name-kana-none");
      Gender.classList.add("gender-none");
      Character.classList.add("character-none");
    }, 130)
  });
}
window.addEventListener('load',RegiFormSwitch);
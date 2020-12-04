function ResourceCalc() {
  const TotalResourcesValue = document.getElementById('total-resources');
  // 家賃入力フォームの取得
  const RentValue = document.getElementById('rent-input');
  const ResourceBrokerageFeeVaule = document.getElementById('resource-brokerage-fee-vaule');

  const SecurityDepositValue = document.getElementById('security-deposit-input');
// 各種入力が行われた時のinput.valueの数値変更処理
  RentValue.addEventListener("input", () => {
    // 家賃
    const GetRentValue = RentValue.value;

    // ※仲介手数料も変更させる。
    ResourceBrokerageFeeVaule.textContent = GetRentValue;
    TotalResourcesMachine();
  });

  function TotalResourcesMachine() {
    TotalResourcesValue.textContent = Number(RentValue.value)+1
  }
}
window.addEventListener('load',ResourceCalc);
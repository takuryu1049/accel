function WorkPlaceSwitch() {
  const CompanySwitch = document.getElementById('company-switch');
  const HumanSwitch = document.getElementById('human-switch');
  const WorkPlace = document.getElementById('switch2-5');
  const RemoveCompanyName = document.getElementById('remove-company-name');
  const RemoveCompanyKanaName = document.getElementById('remove-company-kana-name');
  const RemovePostCode = document.getElementById('remove-post-code');
  const RemovePrefecture = document.getElementById('remove-prefecture');
  const RemoveCity = document.getElementById('remove-city');
  const RemoveStreet = document.getElementById('remove-street');
  const RemoveBuildingName = document.getElementById('remove-building_name');
  const RemoveCompanyPhoneNum= document.getElementById('remove-company_phone_num');
  const RemoveJobDescription = document.getElementById('remove-job_description');
  const ThroughSupportBar = document.querySelector(".support-bar-line2-5");

  if(CompanySwitch.checked == true){
    WorkPlace.classList.add("properties-registration-form-wrap-2-line-5-none");
  }
  CompanySwitch.addEventListener("change", () => {
    WorkPlace.classList.add("properties-registration-form-wrap-2-line-5-none");
    ThroughSupportBar.classList.add("support-through");
    RemoveCompanyName.value = "";
    RemoveCompanyKanaName.value = "";
    RemovePostCode.value = "";
    RemovePrefecture.value = 0;
    RemoveCity.value = "";
    RemoveStreet.value = "";
    RemoveBuildingName.value = "";
    RemoveCompanyPhoneNum.value = "";
    RemoveJobDescription.value = "";
  });
  HumanSwitch.addEventListener("change", () => {
    WorkPlace.classList.remove("properties-registration-form-wrap-2-line-5-none");
    ThroughSupportBar.classList.remove("support-through");
  });
}
window.addEventListener('load',WorkPlaceSwitch);

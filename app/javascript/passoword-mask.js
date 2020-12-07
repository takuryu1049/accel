function PassMask() {
  const PasswordInput = document.querySelector('.password-input');
  const PasswordConfirmationInput = document.querySelector('.password-confirmation-input');
  const PasswordEye = document.querySelector('.password-eye');
  const PasswordConfirmationEye = document.querySelector('.password-confirmation-eye');

  PasswordEye.addEventListener("click", () => {
    if(PasswordInput.type === "password"){
      PasswordInput.type = "text";
      PasswordEye.classList.remove("fa-eye");
      PasswordEye.classList.add("fa-eye-slash"); 
    }else{
      PasswordInput.type = "password";
      PasswordEye.classList.remove("fa-eye-slash");
      PasswordEye.classList.add("fa-eye");
    }
  });

  PasswordConfirmationEye.addEventListener("click", () => {
    if(PasswordConfirmationInput.type === "password"){
      PasswordConfirmationInput.type = "text";
      PasswordConfirmationEye.classList.remove("fa-eye");
      PasswordConfirmationEye.classList.add("fa-eye-slash");
    }else{
      PasswordConfirmationInput.type = "password";
      PasswordConfirmationEye.classList.remove("fa-eye-slash"); 
      PasswordConfirmationEye.classList.add("fa-eye");
    }
  });

}
window.addEventListener('load',PassMask);
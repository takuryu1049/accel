// document.addEventListener('DOMContentLoaded', function(){
//   const CompanyName = document.getElementById('company-name');
//   console.log("読み込まれています");
// };
// function InputPen() {
//   // 必要な要素を全て取得しておく。
//   const inputs = document.querySelectorAll('input');
//   const pen = document.getElementById("pen");
//     inputs.forEach((input)=> {
//       input.addEventListener("keydown", () => {
//         if(pen.classList.contains('pen-none')){
//           pen.classList.remove("pen-none");
//           pen.classList.add('animate__animated',"animate__puls","animate__infinite","input-pen");
//           setTimeout(() => {
//             pen.classList.remove('animate__animated',"animate__pulse","animate__infinite","input-pen");
//             pen.classList.add("pen-none");
//           }, 3000)
//         }
//       });
//     });
//   }
// window.addEventListener('load',InputPen);
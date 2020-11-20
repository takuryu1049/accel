function SortSelect() {
  const SortName = document.getElementById('sort-num');
  SortName.addEventListener("change", () => {
    var num = SortName.value;
    location.href = `/properties/${num}/sort`
  });
}
window.addEventListener('load',SortSelect);
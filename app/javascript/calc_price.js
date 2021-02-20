window.addEventListener('load', () => {

const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
  const price = priceInput.value;
  
  tax = Math.floor(price * 0.1)
  profit = price - tax

  const addTaxDom = document.getElementById("add-tax-price");
  addTaxDom.innerHTML = tax
  const addProfitDom = document.getElementById("profit");
  addProfitDom.innerHTML = profit

  })
});














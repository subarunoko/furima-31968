// function calc_price (){
//   let price = document.getElementById("item-price")
//   // console.log(price)
  
//   let result_tax = price * 0.1
//   let result_profit = price - tax
  
//   let tax = document.getElementById("add-tax-price")
//   // console.log(tax)
//   tax = result_tax
  
//   let profit = document.getElementById("profit")
//   // console.log(profit)
//   result_profit = profit

// };



window.addEventListener('load', () => {
  // console.log("OK");

// const priceInput = document.getElementById("item-price");
// console.log(priceInput);
// priceInput.addEventListener("input", () => {
//    console.log("イベント発火");
// })

// const priceInput = document.getElementById("item-price");
// priceInput.addEventListener("input", () => {
//    const inputValue = priceInput.value;
// })

const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
  const price = priceInput.value;
  // console.log(price);
  
  tax = Math.floor(price * 0.1)
  profit = price - tax

  const addTaxDom = document.getElementById("add-tax-price");
  addTaxDom.innerHTML = tax
  const addProfitDom = document.getElementById("profit");
  addProfitDom.innerHTML = profit

  })
});













// const price = document.getElementById("item-price")
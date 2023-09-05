window.addEventListener('turbo:load', () => {

  const inputPrice = document.getElementById("item-price");

  inputPrice.addEventListener("input", () => {
    const taxPrice = Math.floor(inputPrice.value * 0.1);
    const taxPriceCalculation = document.getElementById("add-tax-price");
    taxPriceCalculation.innerHTML = `${taxPrice}`;
    const profitPrice = inputPrice.value - taxPrice;
    const profitPriceCalculation = document.getElementById("profit");
    profitPriceCalculation.innerHTML = `${profitPrice}`;
  });
});


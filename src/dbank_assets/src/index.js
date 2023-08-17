import { dbank } from "../../declarations/dbank";

window.addEventListener("load", async function(){
  update();
});

document.querySelector("form").addEventListener("submit", async function (event) {
  event.preventDefault();

  // get hold of submit button
  const button = document.querySelector("#submit-btn");

  // define topup & withdraw amount in variables
  const inputAmount = parseFloat(document.querySelector("#input-amount").value);
  const withdrawAmount = parseFloat(document.querySelector("#withdrawal-amount").value);

  // to disable the button while fetching topup() or withdraw()
  button.setAttribute("disabled", true);


  // run topup or withdraw based on user interaction
  if (document.getElementById("input-amount").value.length != 0){
    await dbank.topUp(inputAmount);
  }
  
  if (document.getElementById("withdrawal-amount").value.lenth != 0){
    await dbank.withdraw(withdrawAmount);
  }
  
  // accumulate the time-based interest
  await dbank.compound();

  update();

  // reset the input field value to empty
  document.querySelector("#input-amount").value = "";
  document.querySelector("#withdrawal-amount").value = "";
  
  // re enable the submit button for new transaction
  button.removeAttribute("disabled");
});


// Reflect the current balance after each transaction
async function update(){
  
  const currentBalance = await dbank.checkBalance();
  document.getElementById('value').innerHTML = Math.round(currentBalance * 100) / 100;
}

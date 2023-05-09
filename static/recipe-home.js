'use strict';

// PART 1: SHOW A FORTUNE

function showFortune(evt) {
  // TODO: get the fortune and show it in the #fortune-text div
  fetch('/fortune')
    .then((response) => {
        return response.text()
    })
    .then((serverData) => {
      document.querySelector('#fortune-text').innerHTML = serverData;
    })
}


document.querySelector('#get-fortune-button').addEventListener('click', showFortune);

// PART 2: SHOW WEATHER

function showWeather(evt) {
  evt.preventDefault();

  const url = '/weather.json';
  const zipcode = document.querySelector('#zipcode-field').value;

  // TODO: request weather with that URL and show the forecast in #weather-info
  fetch(`${url}?zipcode=${zipcode}`)
    .then((response) => response.json())
    .then((responseData) => {
      console.log(responseData)
      // document.querySelector('#weather-info').innerHTML = responseData[forecast];
      document.querySelector('#weather-info').innerHTML = responseData.forecast;
    })
}

document.querySelector('#weather-form').addEventListener('submit', showWeather);

// PART 3: ORDER MELONS

function orderMelons(evt) {
  evt.preventDefault();

  // TODO: show the result message after your form
  // TODO: if the result code is ERROR, make it show up in red (see our CSS!)
  const formInputs = {
    qty: document.querySelector('#qty-field').value,
    melon_type: document.querySelector('#melon-type-field').value,
  };

  fetch('/order-melons.json', {
    method: 'POST',
    body: JSON.stringify(formInputs),
    headers: {
      'Content-Type': 'application/json',
    },
  })
    .then((response) => response.json())
    .then((responseJson) => {
      console.log(responseJson);
      console.log(responseJson.code);
      console.log(responseJson.msg);
      console.log(document.querySelector('#order-status'));
      
      // Show the result’s message text in the #order-status div.
      // const orderStatusDiv = document.querySelector('#order-status');
      // console.log(orderStatusDiv)

      // this is our mistake -  innerHtml instead of innerHTML
      // document.querySelector('#order-status').innerHtml = responseJson.msg;
      document.querySelector('#order-status').innerHTML = responseJson.msg;
      if (responseJson.code === "ERROR") {
        // we want the message to appear in red
        // The reason the text wasn't turning red was because we used .order-error
        // but we don't need the ( . ) just 'order-error'
        //document.querySelector('#order-status').classList.add('.order-error');
        document.querySelector('#order-status').classList.add('order-error');
      }
    });

}

document.querySelector('#order-form').addEventListener('submit', orderMelons);

// function getDog (evt) {
//   fetch('https://dog.ceo/api/breeds/image/random')
//   .then((response) => response.json())
//   .then((responseData) => {
//     document.querySelector('#dog-image').insertAdjacentHTML('beforeend', 
//     `<div><img src='${responseData.message}'/></div>`)
//   })
//   }
// document.querySelector('#get-dog-image').addEventListener('click', getDog);

function showWeather(evt) {
  evt.preventDefault();

  const url = '/weather.json';
  const zipcode = document.querySelector('#zipcode-field').value;

  // TODO: request weather with that URL and show the forecast in #weather-info
  fetch(`${url}?zipcode=${zipcode}`)
    .then((response) => response.json())
    .then((responseData) => {
      console.log(responseData)
      // document.querySelector('#weather-info').innerHTML = responseData[forecast];
      document.querySelector('#weather-info').innerHTML = responseData.forecast;
    })
}

document.querySelector('#weather-form').addEventListener('submit', showWeather);

function getRecipe (evt) {
  evt.preventDefault();
  
  while (document.querySelector('#recipe-container').firstChild) {
    document.querySelector('#recipe-container').firstChild.remove();
  }

  const url = 'https://api.spoonacular.com/recipes';
  const ingredients = document.querySelector('#recipe-field').value;
  console.log(ingredients);
  fetch(`${url}/findByIngredients?apiKey=e7716122fcea490aa1c5a7f3c8a9b7e2&ingredients=${ingredients}&number=1`)
  .then((response) => response.json())
  .then((responseData) => {
    console.log(responseData)

    responseData = responseData.sort((a,b) => a.missedIngredientCount - b.missedIngredientCount);


    const foodList =[];
    // foodList.sort((a,b) => a.value - b.value);
    
    for (const foodItem of responseData){
        
      foodList.push(`<div>${foodItem.title}</div>
      <div><img src='${foodItem.image}'/></div>
      <div>Missed Ingredient Count : ${foodItem.missedIngredientCount}</div>
      `)
      
      const eachMissingList = [];
        
        for(const ingredient of foodItem.missedIngredients){
        eachMissingList.push(ingredient.name)
      }
      foodList.push(eachMissingList);
    
    }
   
    document.querySelector('#recipe-container').insertAdjacentHTML('beforeend', 
    `<div>${foodList}</div>`);

    }
    
  )
}

document.querySelector('#recipe-form').addEventListener('submit', getRecipe);
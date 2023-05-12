function addFavorite(recipe_id, event) {
    console.log(event.target)
    
   
    //   if(evt.target.classList.contains('is-favorite')){
    //     evt.target.classList.remove('is-favorite');
    //   }
    //   else {
    //     evt.target.classList.add('is-favorite');
    //   }
   
  
    // const button = evt.target;
    // const buttonId = button.id;
    // console.log(buttonId)
    fetch('/add-favorite', {
      method: 'POST',
      body: JSON.stringify({recipeId:recipe_id}),
      headers: {
        'Content-Type': 'application/json',
      },
    })
      .then((response) => {
        console.log(response)
        return response.text()})
      .then((responseMsg) => {
        
        alert(responseMsg)
  
      }
      
    )
  }
  
  // document.querySelector('.favoritesBtn').addEventListener('click', addFavorite);
  
  
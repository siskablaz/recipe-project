function addFavorite(recipe_id, page, event) {
    console.log(page)
    
    
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
      body: JSON.stringify({recipeId:recipe_id, page:page}),
      headers: {
        'Content-Type': 'application/json',
      },
    })
      .then((response) => {
        console.log(response)
        return response.text()})
      .then((responseMsg) => {
        
        let likeButton = event.target.innerHTML
        let likeCount = Number(likeButton.slice(2))

        let buttonClasses = event.target.classList

       console.log(buttonClasses.contains("favoritesBtn"))

        if (buttonClasses.contains("favoritesBtn") && responseMsg == 'Adding to Favorites') {
            event.target.innerHTML = `♡ ${likeCount+1}`;
            alert(responseMsg)
        }
        else if (responseMsg == 'Removing from Favorites'){
            event.target.innerHTML = `♡ ${likeCount-1}`;
            alert(responseMsg)
        }
        else{
            alert(responseMsg)
            
        }

  
      }
      
    )
  }
  
  // document.querySelector('.favoritesBtn').addEventListener('click', addFavorite);
  
  function addShoppingList(ingredient_name, page, event) {
    
    

    fetch('/add-shopping', {
      method: 'POST',
      body: JSON.stringify({ingredientName:ingredient_name, page:page}),
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



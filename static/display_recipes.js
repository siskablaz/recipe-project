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
      alert(responseMsg)
      //   let likeButton = event.target.innerHTML
      //   let likeCount = Number(likeButton.slice(2))
        
      //   let buttonClasses = event.target.classList

      // console.log(buttonClasses.contains("favoritesBtn"))
      // console.log(likeCount)
      // console.log(event.target.value)
        // if (responseMsg == 'Adding to Favorites') {
        //     event.target.innerHTML = `❤️ ${likeCount+1}`;
        //     document.getElementById(`${event.target.value}`).classList.add('favorited');
        //     alert(responseMsg)
        // }
        // else if (responseMsg == 'Removing from Favorites'){
        //     event.target.innerHTML = `♡ ${likeCount-1}`;
        //     document.getElementById(`${event.target.value}`).classList.remove('favorited');
        //     alert(responseMsg)
        // }
        // else if (responseMsg == 'Removing'){
        //   document.getElementById(`${event.target.value}`).style.display= 'none';
        
        //     alert(responseMsg)
            
        // }
        console.log(`${event.target.id}-div`)
        let likeCountDiv = document.getElementById(`${event.target.id}-div`).innerHTML
        let likeCount = Number(likeCountDiv.slice(2))
        
        let buttonClasses = event.target.classList

        console.log(buttonClasses.contains("favoritesBtn"))
        console.log(likeCount)
        console.log(event.target)
        console.log(event.target.id)
        console.log(responseMsg)
        console.log(likeCountDiv)
        console.log(likeCount)

        if (responseMsg == 'Adding to Favorites') {
          document.getElementById(`${event.target.id}-div`).innerHTML = `❤ ${likeCount+1}`;
          document.getElementById(`${event.target.id}`).classList.add('favorited');
          document.getElementById(`${event.target.id}`).title = ('Remove from Favorites');
          alert(responseMsg)
      }
      else if (responseMsg == 'Removing from Favorites'){
          document.getElementById(`${event.target.id}-div`).innerHTML = `❤ ${likeCount-1}`;
          document.getElementById(`${event.target.id}`).classList.remove('favorited');
          document.getElementById(`${event.target.id}`).title = ('Save to Favorites');
          alert(responseMsg)
      }
      else if (responseMsg == 'Removing'){
        document.getElementById(`${event.target.value}`).style.display= 'none';
      
          alert(responseMsg)
          
      }

  
      }
      
    )
  }
  
  // document.querySelector('.favoritesBtn').addEventListener('click', addFavorite);
  
  function addShoppingList(ingredient_name, event) {
   
    console.log(event.target)
    

    fetch('/add-shopping', {
      method: 'POST',
      body: JSON.stringify({ingredientName:ingredient_name}),
      headers: {
        'Content-Type': 'application/json',
      },
    })
      .then((response) => {
        console.log(response)
        return response.text()})
      .then((responseMsg) => {
        
        alert(responseMsg)
        if (responseMsg == 'Removing from Shopping list'){
          event.target.innerHTML = `+ ${event.target.value}`;
          console.log(event.target.innerHTML);
        }
        else {
          event.target.innerHTML = `-  ${event.target.value}`;
          console.log(event.target.innerHTML);
        }
  
      }
      
    )
  }


  




function completeItem(ingredient_name, event) {
    
    console.log(event.target)

    fetch('/complete-item', {
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
        location.reload(true)
  
      }
      
    )
  }

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
        
        // alert(responseMsg)
        // location.reload(true)

        if (responseMsg == 'Removing from Shopping list'){
          document.getElementById(`shop-list-${event.target.value}`).innerHTML = `<del>${event.target.value}</del>`;
        }
        else if (responseMsg == 'Adding to Shopping list') {
          document.getElementById(`shop-list-${event.target.value}`).innerHTML = `${event.target.value}`;
        }


        // if (responseMsg == 'Removing from Shopping list'){
        //   document.getElementById(`shop-list-${event.target.value}`).innerHTML = `<del>${event.target.value}</del><button onClick= "completeItem('${event.target.value}', event)" type="submit" name="complete-btn" value="${event.target.value}">Add</button>`;
        // }
        // else if (responseMsg == 'Adding to Shopping list') {
        //   document.getElementById(`shop-list-${event.target.value}`).innerHTML = `${event.target.value}<button onClick= "completeItem('${event.target.value}', event)" type="submit" name="complete-btn" value="${event.target.value}">complete</button>`;
        // }

      }
      
    )
  }
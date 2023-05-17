
    
document.querySelector('#rating-form').addEventListener('submit', (evt) => {

    evt.preventDefault();
    
    console.log(document.querySelector('#rating-id-btn').value)
    console.log(document.querySelector('#score').value)
    console.log(document.querySelector('#comment-input').value)
    if (document.querySelector('#rating-id-btn').value){

    
    const formInputs = {
        rating_id: document.querySelector('#rating-id-btn').value,
        updated_score: document.querySelector('#score').value,
        updated_comment: document.querySelector('#comment-input').value

    };

    fetch('/update_rating', {
      method: 'POST',
      body: JSON.stringify(formInputs),
      headers: {
        'Content-Type': 'application/json',
      },
    })
      .then((response) => {
        console.log(response)
        return response.json()})
      .then((responseData) => {
        
        document.querySelector('#rating-score').innerHTML = `rating: ${responseData['averageScore']}`
        document.querySelector('#rating-count').innerHTML = `# of rating: ${responseData['ratingCount']}`
        document.querySelector('#rating-comment').innerHTML = `comment: ${responseData['updatedComment']}`
  
      }
      
    )
    }

    })

  


// import React from "react"; 
// import Card from 'react-bootstrap/Card';
// import ListGroup from 'react-bootstrap/ListGroup';



// function Recipe(props) {
//     return (
//       <div className="recipe-card">
//         <h4>{props.title}</h4>
//         <img src={props.image}></img>
//         <ul>
//           <li>{props.readyMinutes}</li>
//           {props.ingredients.map((ingredient) => (
//             <li>
//               {ingredient}
//             </li>)
//           )}
//         </ul>
//       </div>
    
    
//     );
//   }

{/* <ul className="list-group list-group-flush">
{props.ingredients.map((ingredient) => (
          
          <li className="list-group-item">{ingredient}</li>
 
        ))}
</ul> */}

function Recipe(props) {
  const [favorite, setFavorite] = React.useState('');
  const[favoriteButton, setFavoriteButton] = React.useState('red')
  // const[buttonColor, setButtonColor] = React.useState(renderFavButton(props.recipe_id))

  // {
  // props.currFavRecipes.indexOf(props.recipeId) !== -1 ? setFavoriteButton("red") : setFavoriteButton("white")
  // } 

  // function renderFavButton(recipe_id) {
  //   fetch('/is-favorite-react', {
  //     method: 'POST',
  //     body: JSON.stringify({recipeId:recipe_id}),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //   })
  //   .then( (resp) => resp.text())
  //   .then( (response) => {
  //     return response
  //   })

  // }
  



  function handleFavorite(evt) {
   
    console.log(evt.target.id);
    setFavorite(evt.target.id);

    let recipe_id = evt.target.id
    // setButtonColor(buttonColor==='red'?'white':'red')
    fetch('/add-favorite-react', {
      method: 'POST',
      body: JSON.stringify({recipeId:recipe_id}),
      headers: {
        'Content-Type': 'application/json',
      },
    })
      .then( (resp) => resp.text())
      .then( (response) => {
          alert(response)

          // extract particular attributes sent in response from the server and store them in state
          if (response == 'Removing from Favorites'){
            setFavoriteButton("white")
            console.log(favoriteButton)
          } 
          else if (response == 'Adding to Favorites'){
          
            setFavoriteButton("red")
            console.log(favoriteButton)
          }

      })
  }

    return (
  <div className="card" style={{width: "18rem", minWidth: "18rem", height: "27rem", margin: "1rem"}}>
  <img src={props.image} className="card-img-top" alt="..."/>



{
  props.currFavRecipes.indexOf(props.recipeId) !== -1 ?  <i style={{position: "inherit", top: "-212px", left: "8px", color:`${favoriteButton}`}} title="Save to favorites"  id={props.recipeId} class="favResultsBtn favorited mt-2 fab fa-gratipay fa-2x" onClick = {handleFavorite} value={props.recipeId} ></i> :
                                    <i style={{position: "inherit", top: "-212px", left: "8px", color:`${favoriteButton}`}} title="Save to favorites"  id={props.recipeId} class="favResultsBtn not-favorited mt-2 fab fa-gratipay fa-2x" onClick = {handleFavorite} value={props.recipeId} ></i>
}
  
  <div className="card-body" style={{position: "relative",top: "-40px", overflow:"auto"}}>
    <h5 className="card-title" style={{fontWeight: "bold"}}>{props.title}</h5>
    <h4 className="card-title" style={{color: "green", fontSize: "20px"}}>Ready: {props.readyMinutes} min.</h4>
    <p className="card-text">ingredients: {(props.ingredients).length} </p>


  </div>
  

  <div className="footer" style={{height: "50px", position: "absolute", bottom:"4px"}} >

  <p className="txt3" style={{display: "flex", "justify-content": "space-between"}}>
      <a style={{color: "gray","margin-right": "7px"}} id={'res-fav-'+props.recipeId+'-div'}>❤ {props.favCount}</a> 
      <a style={{"text-decoration": "none", color: "gray"}} href={'/recipes/'+props.recipeId } ><i style={{"margin-right": "7px"}} className="bi bi-book"></i>Details</a>
      <span className="comments"><a style={{"text-decoration": "none", color: "gray"}} href={'/recipes/'+props.recipeId} ><i className="fas fa-comments"></i>{props.ratingCount} Comments</a></span>
  </p>
</div>


</div>
);

} 


// function KitchenSinkExample() {
//   return (
//     <Card style={{ width: '18rem' }}>
//       <Card.Img variant="top" src={props.image} />
//       <Card.Body>
//         <Card.Title>{props.title}</Card.Title>
//         <Card.Text>
//           Some quick example text to build on the card title and make up the
//           bulk of the card's content.
//         </Card.Text>
//       </Card.Body>
//       <ListGroup className="list-group-flush">
//         <ListGroup.Item>{props.ingredients}</ListGroup.Item>
//         <ListGroup.Item>Dapibus ac facilisis in</ListGroup.Item>
//         <ListGroup.Item>Vestibulum at eros</ListGroup.Item>
//       </ListGroup>
//       <Card.Body>
//         <Card.Link href="#">Card Link</Card.Link>
//         <Card.Link href="#">Another Link</Card.Link>
//       </Card.Body>
//     </Card>
//   );
// }


// export default KitchenSinkExample;


function AllPopularRecipes() {
    const [recipeData, setRecipeData] = React.useState([]);
    const [currFavRecipes, setCurrFavRecipes ]= React.useState([]);
    // nothing in dependency array means called on first render
    React.useEffect( () => {
        fetch('/popular-recipes.json')
        .then( (response) => {
            console.log(response)
            return response.json()} )
        .then((resp) => { 
            // resp.results is an array of objects
            console.log("CURRENT FAVORITES");
            console.log(resp["curr_fav_recipes"]);
            // setRecipeData(resp);
            setRecipeData(resp["pop_recipes"]);
            // console.log(resp)+
            setCurrFavRecipes(resp["curr_fav_recipes"]);
        })
    }, [] );

    return (
        <div className="example-section">
            <h2 style={{"text-align": "center", "margin-top": "25px", "margin-bottom": "25px", "border-top": "none"}}>Popular Recipes</h2>
            <div id="recipes-container" style={{display: "flex", "flex-wrap": "wrap", "justify-content":"center"}} >
                {
                    recipeData.length > 0  
                    ? (
                        recipeData.map( (recipe) =>
                          <Recipe recipeId={recipe.recipe_id} 
                            readyMinutes={recipe.ready_minutes} 
                            title={recipe.title} 
                            image={recipe.image}
                            ingredients = {recipe.ingredients} 
                            favCount = {recipe.fav_count} 
                            ratingCount = {recipe.rating_count} 
                            ratingAvg = {recipe.rating_avg} 
                            currFavRecipes = {currFavRecipes}
                            /> 
                        )
                      )
                    : <div className="loading">Loading...</div>
                }
            </div>
        </div>
    )
}



ReactDOM.render(<AllPopularRecipes />, document.querySelector("#root"));
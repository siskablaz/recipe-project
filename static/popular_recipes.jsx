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
    return (
  <div className="card" style={{width: "18rem", minWidth: "18rem", margin: "1rem"}}>
  <img src={props.image} className="card-img-top" alt="..."/>
  <div className="card-body">
    <h5 className="card-title" style={{fontWeight: "bold"}}>{props.title}</h5>
    <h4 className="card-title" style={{color: "green", fontSize: "20px"}}>Ready: {props.readyMinutes} min.</h4>
    <p className="card-text">ingredients: {(props.ingredients).length} </p>
  </div>
  

  <div className="card-body">
    <a href={'/recipes/'+props.recipeId} className="card-link" >Recipe Details</a>

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

    // nothing in dependency array means called on first render
    React.useEffect( () => {
        fetch('/popular-recipes.json')
        .then( (response) => {
            console.log(response)
            return response.json()} )
        .then((resp) => {
            // resp.results is an array of objects
            console.log(resp[0]["image"])
            setRecipeData(resp);
        })
    }, [] );

    return (
        <div className="example-section">
            <h2>Popular Recipes</h2>
            <div id="recipes-container" style={{display: "flex", "flex-wrap": "wrap"}} >
                {
                    recipeData.length > 0  
                    ? (
                        recipeData.map( (recipe) =>
                          <Recipe recipeId={recipe.recipe_id} 
                            readyMinutes={recipe.ready_minutes} 
                            title={recipe.title} 
                            image={recipe.image}
                            ingredients = {recipe.ingredients} 
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
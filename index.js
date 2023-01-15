const express = require('express');
const app = express();
const {db}=require("./config")

//Port to serve
const PORT = process.env.PORT || 3000;

//Routes
app.get('/', (req, res) => {
  res.send('Welcome to Node Express Server');
});

app.post('/createUser', async(req,res)=>{
  try {
    const docRef = await addDoc(collection(db, "users"), {
      first: "Alan",
      middle: "Mathison",
      last: "Turing",
      born: 1912
    });
  
    console.log("Document written with ID: ", docRef.id);
  } catch (e) {
    console.error("Error adding document: ", e);
  }
})

//Start the server
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
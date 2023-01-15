const express = require("express");
const admin = require("firebase-admin");
const app = express();
const { db } = require("./config");

//Port to serve
const PORT = process.env.PORT || 3000;

//Routes
app.get("/", (req, res) => {
  res.send("Welcome to Node Express Server");
});

app.post("/createUser", async (req, res) => {
  try {
    const docRef = await db.collection("Users").doc("1").set({
      ID: "1",
      Name: "Aman",
      Age: "20",
    });
    res.status(200).send(docRef);

    console.log("Document written with ID: ", docRef.ID);
  } catch (e) {
    console.error("Error adding document: ", e);
    res.status(500).send(e);
  }
});

//Start the server
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

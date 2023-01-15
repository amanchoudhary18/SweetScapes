const { initializeApp }= require('firebase/app');
const { getFirestore, addDoc, collection  } = require('firebase/firestore');

// TODO: Replace the following with your app's Firebase project configuration
// See: https://firebase.google.com/docs/web/learn-more#config-object
const firebaseConfig = {
    apiKey: "AIzaSyDqJUlb2SdUlkPtt4FAtpJ_TfvziU0QlOY",

    authDomain: "sweetscape.firebaseapp.com",
  
    databaseURL: "https://sweetscape-default-rtdb.firebaseio.com",
  
    projectId: "sweetscape",
  
    storageBucket: "sweetscape.appspot.com",
  
    messagingSenderId: "770966537264",
  
    appId: "1:770966537264:web:7bb629e9a1d35918e859f5"
  
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);


// Initialize Cloud Firestore and get a reference to the service
const db = getFirestore(app);
exports.db=db

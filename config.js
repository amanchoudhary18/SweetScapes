const { initializeApp } = require("firebase/app");
const { getFirestore, addDoc, collection } = require("firebase/firestore");
const admin = require("firebase-admin");
const serviceAccount = require("./serviceKey.json");

// TODO: Replace the following with your app's Firebase project configuration
// See: https://firebase.google.com/docs/web/learn-more#config-object
const firebaseConfig = {
  apiKey: "AIzaSyAwumtb4VCuJQZKvXxRQouUViidleM_AEQ",
  authDomain: "sweetscapes-47eb3.firebaseapp.com",
  projectId: "sweetscapes-47eb3",
  storageBucket: "sweetscapes-47eb3.appspot.com",
  messagingSenderId: "930049639322",
  appId: "1:930049639322:web:2dd3eb33bbfb5f6d98f023",
  measurementId: "G-6WDPSSFX7H",
};
// Initialize Firebase
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});
const firestore = admin.firestore();

// Initialize Cloud Firestore and get a reference to the service
exports.db = firestore;

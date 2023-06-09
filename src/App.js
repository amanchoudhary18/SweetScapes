import "./App.css";
import Hero from "./components/Hero.js";
import Navbar from "./components/Navbar";
import Collage from "./components/Collage";
import Why from "./components/Why";
import People from "./components/People";
import Coming from "./components/Coming";
import Footer from "./components/Footer";

function App() {
  return (
    <div className="App" id="hero">
      <Navbar />
      <Hero />
      <Collage />
      <Why />
      <People />
      <Coming />
      <Footer />
    </div>
  );
}

export default App;

import "./App.css";
import Hero from "./components/Hero.js";
import Navbar from "./components/Navbar";
import Collage from "./components/Collage";
import Why from "./components/Why";
import People from "./components/People";
import Coming from "./components/Coming";

function App() {
  return (
    <div className="App" id="hero">
      <Navbar />
      <Hero />
      <Collage />
      <Why />
      <People />
      <Coming />
    </div>
  );
}

export default App;

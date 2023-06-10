import React from "react";
import "./Hero.css";

const Hero = () => {
  return (
    <>
      <div className="hero">
        <div className="hero-text fade-in-image">
          <p className="hero-primary-text">Discover, Experience, </p>
          <p className="hero-primary-text">and Make Memories</p>
          <p className="hero-primary-text"> with SweetScapes</p>
        </div>

        <div className="hero-cta fade-in-image">
          <button type="button" className="hero-cta-button">
            <a href="#coming">Sign Up for Updates</a>
          </button>
          <p className="hero-cta-secondary-text">
            Recieve all updates of our upcoming app
          </p>
        </div>
      </div>
    </>
  );
};

export default Hero;

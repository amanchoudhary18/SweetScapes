import React, { useEffect, useState } from "react";
import lightLogo from "../assets/images/white-logo.png";
import darkLogo from "../assets/images/black-logo.png";
import "./Navbar.css";
import { BsInstagram, BsLinkedin } from "react-icons/bs";
import { SiGmail } from "react-icons/si";

const Navbar = () => {
  const [scrolled, setScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      const isScrolled = window.scrollY > 540 && window.scrollY < 1215;
      setScrolled(isScrolled);
    };

    window.addEventListener("scroll", handleScroll);

    return () => {
      window.removeEventListener("scroll", handleScroll);
    };
  }, []);

  const light = (
    <div className="navbar" style={{ borderBottom: "1px solid #d0d0d0" }}>
      <div className="navbar-logo">
        <a href="#hero">
          <img src={lightLogo} alt="our logo" />
        </a>
      </div>

      <div className="navbar-elements">
        <a href="#about">
          <p>About</p>
        </a>
        <a href="#why">
          <p>How it works</p>
        </a>
        <a href="#groups">
          <p>Features</p>
        </a>

        <a href="#coming">
          <p className="coming-soon-btn">Coming soon</p>
        </a>
      </div>

      <div className="navbar-icons">
        <BsInstagram size="18px" style={{ margin: "5px 0 " }} />
        <BsLinkedin size="18px" style={{ margin: "5px 0" }} />
        <SiGmail size="22px" style={{ margin: "3px 0" }} />
      </div>
    </div>
  );

  const dark = (
    <div className="navbar dark">
      <div className="navbar-logo">
        <a href="#hero">
          <img src={darkLogo} alt="our logo" />
        </a>
      </div>

      <div className="navbar-elements">
        <a href="#about">
          <p>About</p>
        </a>
        <a href="#why">
          <p>How it works</p>
        </a>
        <a href="#groups">
          <p>Features</p>
        </a>

        <a href="#coming">
          <p className="coming-soon-btn">Coming soon</p>
        </a>
      </div>

      <div className="navbar-icons">
        <a href="https://www.instagram.com/sweetscapes.in/">
          <BsInstagram size="18px" color="white" style={{ margin: "5px 0 " }} />
        </a>

        <BsLinkedin size="18px" color="white" style={{ margin: "5px 0" }} />
        <SiGmail size="22px" color="white" style={{ margin: "3px 0" }} />
      </div>
    </div>
  );

  return <>{scrolled ? dark : light}</>;
};

export default Navbar;

import React, { useEffect, useState } from "react";
import lightLogo from "../assets/images/white-logo.png";
import darkLogo from "../assets/images/black-logo.png";
import icon from "../assets/images/icon.png";
import "./Navbar.css";
import { BsInstagram, BsLinkedin } from "react-icons/bs";
import { SiGmail } from "react-icons/si";
import { GiHamburgerMenu } from "react-icons/gi";
import { IoCloseOutline } from "react-icons/io5";

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

  const [openOptions, setOpenOptions] = useState(false);

  const light = (
    <>
      <div
        className="navbar desktop"
        style={{ borderBottom: "1px solid #d0d0d0" }}
      >
        <div className="navbar-logo ">
          <a href="#hero">
            <img src={lightLogo} alt="our logo" />
          </a>
        </div>

        <div className="navbar-elements ">
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

        <div className="navbar-icons ">
          <a
            href="https://www.instagram.com/sweetscapes.in/"
            target="_blank"
            rel="noreferrer"
          >
            <BsInstagram
              size="18px"
              color="black"
              style={{ margin: "5px 0 " }}
            />
          </a>

          <a
            href="https://www.linkedin.com/company/sweetscapes"
            target="_blank"
            rel="noreferrer"
          >
            <BsLinkedin size="18px" color="black" style={{ margin: "5px 0" }} />
          </a>

          <a
            href="mailto:sweetscapes.organization@gmail.com"
            target="_blank"
            rel="noreferrer"
          >
            <SiGmail size="22px" color="black" style={{ margin: "3px 0" }} />
          </a>
        </div>
      </div>

      <div className="resp">
        <div
          className="navbar"
          style={
            !openOptions
              ? { borderBottom: "1px solid #d0d0d0" }
              : { borderBottom: "none" }
          }
        >
          <div className="navbar-logo">
            <a href="#hero">
              <img
                src={icon}
                alt="our logo"
                width="35px"
                style={{ height: "35px" }}
              />
            </a>

            {!openOptions ? (
              <GiHamburgerMenu
                size={"30px"}
                style={{ margin: "8px" }}
                onClick={() => setOpenOptions(true)}
              />
            ) : (
              <IoCloseOutline
                size={"30px"}
                style={{ margin: "8px" }}
                onClick={() => setOpenOptions(false)}
              />
            )}
          </div>
        </div>
      </div>

      {openOptions && (
        <div
          className="navbar-elements resp"
          style={
            openOptions
              ? {
                  borderBottom: "1px solid #d0d0d0",
                  boxSizing: "border-box",
                  width: "100%",
                }
              : { boxSizing: "border-box", width: "100%" }
          }
        >
          <a href="#about">
            <p onClick={() => setOpenOptions(false)}>About</p>
          </a>
          <a href="#why">
            <p onClick={() => setOpenOptions(false)}>How it works</p>
          </a>
          <a href="#groups">
            <p onClick={() => setOpenOptions(false)}>Features</p>
          </a>

          <a href="#coming">
            <p
              className="coming-soon-btn"
              onClick={() => setOpenOptions(false)}
            >
              Coming soon
            </p>
          </a>
        </div>
      )}
    </>
  );

  const dark = (
    <div className="navbar dark desktop">
      <div className="navbar-logo ">
        <a href="#hero">
          <img src={darkLogo} alt="our logo" />
        </a>
      </div>

      <div className="navbar-elements ">
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
        <a
          href="https://www.instagram.com/sweetscapes.in/"
          target="_blank"
          rel="noreferrer"
        >
          <BsInstagram size="18px" color="white" style={{ margin: "5px 0 " }} />
        </a>

        <a
          href="https://www.linkedin.com/company/sweetscapes"
          target="_blank"
          rel="noreferrer"
        >
          <BsLinkedin size="18px" color="white" style={{ margin: "5px 0" }} />
        </a>

        <a
          href="mailto:sweetscapes.organization@gmail.com"
          target="_blank"
          rel="noreferrer"
        >
          <SiGmail size="22px" color="white" style={{ margin: "3px 0" }} />
        </a>
      </div>
    </div>
  );

  return <>{scrolled ? dark : light}</>;
};

export default Navbar;

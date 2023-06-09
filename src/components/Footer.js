import React from "react";
import { BsInstagram, BsLinkedin, BsFillEnvelopeFill } from "react-icons/bs";
import "./Footer.css";

const Footer = () => {
  const currentYear = new Date().getFullYear();

  return (
    <footer className="footer">
      <div className="container">
        <div className="footer-body">
          <div className="website-links">
            <h3>Important Links</h3>
            <div className="page-links">
              <p>About Us</p>
              <p>How it Works</p>
              <p>Features</p>
              <p>Coming Soon</p>
            </div>
          </div>

          <div className="website-links" style={{ textAlign: "center" }}>
            <h3>Contact Us </h3>
            <div className="social-links">
              <a
                href="https://www.instagram.com/sweetscapes.in/"
                target="_blank"
                rel="noreferrer"
              >
                <BsInstagram size="18px" color="black" />
              </a>

              <a
                href="https://www.linkedin.com/company/sweetscapes"
                target="_blank"
                rel="noreferrer"
              >
                <BsFillEnvelopeFill size="18px" color="black" />
              </a>

              <a
                href="mailto:sweetscapes.organization@gmail.com"
                target="_blank"
                rel="noreferrer"
              >
                <BsLinkedin size="18px" color="black" />
              </a>
            </div>
          </div>
        </div>
      </div>
      <div className="last-line">
        <p>SweetScapes</p>
        <p>&copy; Copyright. All Rights Reserved</p>
      </div>
    </footer>
  );
};

export default Footer;

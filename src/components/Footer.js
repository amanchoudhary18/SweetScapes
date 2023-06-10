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
              <a href="#hero">
                <p style={{ fontWeight: "600" }}>Go to top</p>{" "}
              </a>
              <a href="#about">
                <p>About Us</p>{" "}
              </a>

              <a href="#why">
                <p>How it Works</p>{" "}
              </a>
              <a href="#groups">
                <p>Features</p>{" "}
              </a>
              <a href="#coming">
                <p>Coming Soon</p>{" "}
              </a>
            </div>
          </div>

          <div
            className="website-links desktop"
            style={{ textAlign: "center" }}
          >
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

          <div className="website-links resp" style={{ textAlign: "right" }}>
            <h3>Contact Us </h3>
            <div className="social-links" style={{ marginTop: "38px" }}>
              <a
                href="https://www.instagram.com/sweetscapes.in/"
                target="_blank"
                rel="noreferrer"
              >
                <BsInstagram size="14px" color="black" />
              </a>

              <a
                href="https://www.linkedin.com/company/sweetscapes"
                target="_blank"
                rel="noreferrer"
              >
                <BsFillEnvelopeFill size="14px" color="black" />
              </a>

              <a
                href="mailto:sweetscapes.organization@gmail.com"
                target="_blank"
                rel="noreferrer"
              >
                <BsLinkedin size="14px" color="black" />
              </a>
            </div>
          </div>
        </div>
      </div>
      <div className="last-line desktop">
        <p>SweetScapes</p>
        <p>&copy; Copyright. All Rights Reserved</p>
      </div>

      <div className="last-line resp">
        <p>SweetScapes&copy; Copyright. All Rights Reserved</p>
      </div>
    </footer>
  );
};

export default Footer;

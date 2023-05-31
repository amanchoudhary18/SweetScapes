import React, { useRef, useState, useEffect } from "react";
import img1 from "../assets/images/1.jpeg";
import img2 from "../assets/images/2.jpeg";
import img3 from "../assets/images/3.jpeg";
import img4 from "../assets/images/4.jpg";
import img5 from "../assets/images/5.jpg";
import img6 from "../assets/images/6.jpg";
import img7 from "../assets/images/7.jpg";
import img8 from "../assets/images/8.jpg";
import "./Collage.css";

const Collage = () => {
  const domRef = useRef();
  const [isVisible, setVisible] = useState(true);
  useEffect(() => {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach((entry) => setVisible(entry.isIntersecting));
    });
    const current = domRef.current;
    observer.observe(current);
    return () => observer.unobserve(current);
  }, []);

  return (
    <div className="collage" id="about">
      <div className="collage-overlay">
        <div
          style={{ margin: "250px 0" }}
          className={`fade-in-section ${isVisible ? "is-visible" : ""}`}
          ref={domRef}
        >
          {" "}
          <p className="collage-overlay-text">A place where</p>
          <p className="collage-overlay-text">extraordinary moments begin</p>
        </div>
      </div>
      <div className="collage-pictures-row">
        <div className="collage-pictures-col" style={{ maxWidth: "25%" }}>
          <img src={img1} alt="img1" />
          <img src={img5} alt="img5" />
        </div>
        <div className="collage-pictures-col" style={{ maxWidth: "25%" }}>
          <img src={img6} alt="img5" />
          <img src={img2} alt="img1" />
        </div>
        <div className="collage-pictures-col" style={{ maxWidth: "25%" }}>
          <img src={img3} alt="img1" />
          <img src={img7} alt="img5" />
        </div>
        <div className="collage-pictures-col" style={{ maxWidth: "25%" }}>
          <img src={img8} alt="img5" />
          <img src={img4} alt="img1" />
        </div>
      </div>
    </div>
  );
};

export default Collage;

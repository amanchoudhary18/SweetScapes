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
  return (
    <div className="collage" id="about">
      <div className="collage-overlay">
        <div className="desktop">
          <p className="collage-overlay-text">A place where</p>
          <p className="collage-overlay-text">extraordinary moments begin</p>
        </div>

        <div className="resp">
          <p className="collage-overlay-text" style={{ paddingTop: " 120px" }}>
            A place where extraordinary{" "}
          </p>
          <p className="collage-overlay-text">moments begin</p>
        </div>
      </div>
      <div className="collage-pictures-row desktop">
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

      <div className="resp">
        <div className="collage-pictures-row ">
          <div className="collage-pictures-col" style={{ maxWidth: "50%" }}>
            <img src={img6} alt="img1" height="130px" />
            <img src={img5} alt="img5" height="130px" />
            <img src={img1} alt="img5" />
          </div>
          <div className="collage-pictures-col" style={{ maxWidth: "50%" }}>
            <img src={img7} alt="img5" height="130px" />
            <img src={img8} alt="img1" height="130px" />
            <img src={img2} alt="img5" />
          </div>
        </div>
      </div>
    </div>
  );
};

export default Collage;

import React, { useState } from "react";
import "./Why.css";
import illustration1 from "../assets/images/illus1.png";
import illustration2 from "../assets/images/illus2.png";
import illustration3 from "../assets/images/illus3.png";
import illustration4 from "../assets/images/illus4.png";
import illustration1Hover from "../assets/images/illus1-hover.png";
import { hover } from "@testing-library/user-event/dist/hover";

const Why = () => {
  const [illus1, setIllus1] = useState(illustration1);
  return (
    <div>
      <div className="why-head" id="why">
        <p className="why-heading">The SweetScapes Method</p>
        <p className="why-subheading">
          Uniquely Crafted Recommendations, Thoughtful Curation, and Seamless
          Planning
        </p>
        <p className="why-subheading">for Extraordinary Adventures.</p>
        <div className="why-head-col">
          <div className="why-head-row">
            <div
              className="why-head-row-2"
              onMouseEnter={() => {
                setIllus1(illustration1Hover);
              }}
              onMouseLeave={() => {
                setIllus1(illustration1);
              }}
            >
              <div style={{ width: "max-content" }}>
                <p className="why-head-row-title" style={{ color: "white" }}>
                  Personalize Your Profile
                </p>
                <p
                  className="why-head-row-para"
                  style={{ color: "rgb(240, 240, 240)" }}
                >
                  Tell us your preferences, interests,
                </p>
                <p
                  className="why-head-row-para"
                  style={{ color: "rgb(240, 240, 240)" }}
                >
                  and desired outing experiences.
                </p>
              </div>

              <div
                style={{
                  maxWidth: "max-content",
                  marginLeft: "auto",
                  padding: "0 48px 16px",
                }}
              >
                <img src={illus1} alt="illustration" height="380px" />
              </div>
            </div>
            <div className="why-head-row-1">
              <div style={{ width: "max-content" }}>
                <p className="why-head-row-title">
                  Discover Tailored Recommendations
                </p>
                <p className="why-head-row-para">
                  Our machine learning algorithms analyze your profile and
                </p>
                <p className="why-head-row-para">
                  suggest unique outings, handpicked just for you.
                </p>

                <div
                  style={{
                    maxWidth: "max-content",
                    marginLeft: "auto",
                    padding: "0 16px 16px",
                  }}
                >
                  <img src={illustration2} alt="illustration" height="400px" />
                </div>
              </div>
            </div>
          </div>
          <div className="why-head-row">
            <div className="why-head-row-4">
              <div style={{ width: "max-content", marginBottom: "0px" }}>
                <p className="why-head-row-title" style={{ color: "white" }}>
                  Plan with Ease
                </p>
                <p
                  className="why-head-row-para"
                  style={{ color: "rgb(240, 240, 240)" }}
                >
                  Our intuitive app interface allows you to seamlessly schedule
                </p>
                <p
                  className="why-head-row-para"
                  style={{ color: "rgb(240, 240, 240)" }}
                >
                  activities, make reservations, and coordinate logistics.
                </p>
              </div>

              <div
                style={{
                  maxWidth: "max-content",
                  margin: "auto",
                  padding: "20px 16px 16px",
                }}
              >
                <img src={illustration3} alt="illustration" height="300px" />
              </div>
            </div>
            <div className="why-head-row-3">
              <div style={{ width: "max-content", marginBottom: "0px" }}>
                <p className="why-head-row-title" style={{ color: "white" }}>
                  Embark on Extraordinary Experiences
                </p>
                <p
                  className="why-head-row-para"
                  style={{ color: "rgb(240, 240, 240)" }}
                >
                  Follow our curated itineraries, visit recommended venues,
                </p>
                <p
                  className="why-head-row-para"
                  style={{ color: "rgb(240, 240, 240)" }}
                >
                  and immerse yourself in unforgettable outings.
                </p>
              </div>
              <div
                style={{
                  maxWidth: "max-content",
                  marginLeft: "auto",
                  padding: "20px 16px 16px",
                }}
              >
                <img src={illustration4} alt="illustration" height="380px" />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Why;

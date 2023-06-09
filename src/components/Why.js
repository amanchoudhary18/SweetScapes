import React, { useState } from "react";
import "./Why.css";
import illustration1 from "../assets/images/illus1.jpg";
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
            <div>
              <div
                style={{
                  width: "max-content",
                  margin: "auto",
                }}
              >
                <img src={illustration1} alt="illustration" />
              </div>

              <div
                style={{
                  margin: "auto",
                  textAlign: "center",
                }}
              >
                <p className="why-head-row-title">Personalize Your Profile</p>
                <p className="why-head-row-para">
                  Tell us your preferences, interests, and desired outing
                  experiences.
                </p>
              </div>
            </div>

            <div>
              <div
                style={{
                  width: "max-content",
                  margin: "auto",
                }}
              >
                <img src={illustration2} alt="illustration" />
              </div>

              <div
                style={{
                  margin: "auto",
                  textAlign: "center",
                }}
              >
                <p className="why-head-row-title">Find Tailored Picks</p>
                <p className="why-head-row-para">
                  Our machine learning algorithms analyze your profile and
                  suggest unique outings, handpicked just for you.
                </p>
              </div>
            </div>

            <div>
              <div
                style={{
                  margin: "auto",
                }}
              >
                <img src={illustration3} alt="illustration" />
              </div>

              <div
                style={{
                  margin: "auto",
                  textAlign: "center",
                }}
              >
                <p className="why-head-row-title">Plan with Ease</p>
                <p className="why-head-row-para">
                  Our intuitive app interface allows you to seamlessly schedule
                  activities, make reservations, and coordinate logistics.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Why;

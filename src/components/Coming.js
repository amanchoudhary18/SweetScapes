import React from "react";
import "./Coming.css";

const Coming = () => {
  return (
    <div>
      <div className="coming" id="coming">
        <p className="coming-heading">SweetScapes is coming soon</p>
        <p className="coming-heading">
          across all{" "}
          <span style={{ color: "#A4C639", fontWeight: "700" }}>Android</span>{" "}
          and <span style={{ color: "black", fontWeight: "700" }}>iOS</span>{" "}
          devices
        </p>

        <div className="coming-cta ">
          <input type="text" placeholder="Enter your email address" />
          <button type="button" className="coming-cta-button">
            Sign Up for Updates
          </button>
        </div>
      </div>
    </div>
  );
};

export default Coming;

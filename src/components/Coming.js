import React, { useState } from "react";
import axios from "axios";
import "./Coming.css";

const Coming = () => {
  const [email, setEmail] = useState("");
  const handleEmail = (e) => {
    setEmail(e.target.value);
  };

  const submitEmail = async () => {
    const res = await axios.post(
      "https://date-form-prod.onrender.com/api/vi/email/addEmail",
      {
        email: email,
      }
    );

    console.log(res);
  };

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
          <input
            type="text"
            placeholder="Enter your email address"
            onChange={handleEmail}
          />
          <button
            type="button"
            className="coming-cta-button"
            onClick={submitEmail}
          >
            Sign Up for Updates
          </button>
        </div>
      </div>
    </div>
  );
};

export default Coming;

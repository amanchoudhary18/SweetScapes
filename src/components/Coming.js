import React, { useState } from "react";
import axios from "axios";
import "./Coming.css";

const Coming = () => {
  const [email, setEmail] = useState("");

  const verifyEmail = (input) => {
    var validRegex =
      /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;

    if (input.match(validRegex)) return true;
    else return false;
  };

  const handleEmail = (e) => {
    if (e.target.value) setEmail(e.target.value);
  };

  const submitEmail = async () => {
    try {
      if (email === "") {
        alert("Empty Input Not Allowed");
      } else if (!verifyEmail(email)) {
        alert("Enter Valid Email");
      }

      const res = await axios.post(
        "https://date-form-prod.onrender.com/api/v1/email/addEmail",
        {
          email: email,
        }
      );
    } catch (error) {
      alert(error.message);
    }
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
        <div className="coming-cta">
          <input
            type="text"
            placeholder="Enter your email address"
            onChange={handleEmail}
          />

          <button
            type="button"
            className="coming-cta-button"
            style={{ backgroundolor: "grey" }}
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

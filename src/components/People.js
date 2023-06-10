import { useEffect, useState } from "react";
import "./People.css";
import solo from "../assets/images/solo.png";
import couple from "../assets/images/couple.jpg";
import friends from "../assets/images/friends.jpg";

const People = () => {
  const text = [
    "Discover immersive experiences and solo-friendly activities that will make your journey truly unique and fulfilling. Whether it's exploring a new city, delving into local culture, or indulging in self-care, we at SweetScapes have curated recommendations tailored for solo travelers.",
    "SweetScapes excels at crafting intimate and enchanting experiences for couples. Discover cozy and romantic settings, indulge in exquisite dining options, and create cherished memories with your loved one.",
    "Planning a memorable outing with your friends? SweetScapes offers exciting recommendations for group adventures. From thrilling activities to lively venues, we ensure an unforgettable time filled with laughter and camaraderie.",
    "Need to plan an outing for a larger group? SweetScapes has you covered. Whether it's a family celebration, a corporate event, or a special occasion, we provide tailored recommendations and seamless planning to make the experience truly unforgettable.",
  ];

  const images = [solo, couple, friends];

  const [selected, setSelected] = useState([true, false, false]);
  const [bodyText, setBodyText] = useState(text[0]);
  const [bodyImage, setBodyImage] = useState(images[0]);

  const styleSelected = {
    color: "black",
    backgroundColor: "white",
    fontWeight: "600",
    transition: "background-color 0.3s ease-in",
  };

  useEffect(() => {
    const interval = setInterval(() => {
      console.log(selected);

      if (JSON.stringify(selected) === JSON.stringify([true, false, false])) {
        setBodyText(text[1]);
        setBodyImage(images[1]);
        setSelected([false, true, false]);
      } else if (
        JSON.stringify(selected) === JSON.stringify([false, true, false])
      ) {
        setBodyText(text[2]);
        setBodyImage(images[2]);
        setSelected([false, false, true]);
      } else if (
        JSON.stringify(selected) === JSON.stringify([false, false, true])
      ) {
        setBodyText(text[0]);
        setBodyImage(images[0]);
        setSelected([true, false, false]);
      }
    }, 5000);

    return () => clearInterval(interval);
  });

  const styleNotSelected = { fontWeight: "400" };
  return (
    <div id="groups">
      <div className="people">
        <div className="people-left">
          <p className="people-heading">
            The perfect outings for every group size
          </p>

          <div className="people-selector resp" style={{ display: "flex" }}>
            <p
              style={selected[0] ? styleSelected : styleNotSelected}
              onClick={() => {
                setSelected([true, false, false]);
                setBodyImage(images[0]);
                setBodyText(text[0]);
              }}
            >
              Solo Adventures
            </p>
            <p
              style={selected[1] ? styleSelected : styleNotSelected}
              onClick={() => {
                setSelected([false, true, false]);
                setBodyImage(images[1]);
                setBodyText(text[1]);
              }}
            >
              Dates for Couples
            </p>
            <p
              style={selected[2] ? styleSelected : styleNotSelected}
              onClick={() => {
                setSelected([false, false, true]);
                setBodyImage(images[2]);
                setBodyText(text[2]);
              }}
            >
              Gatherings with Friends
            </p>
          </div>
          <div className="people-body-text">
            <p style={{ animation: "fade-in 0.3s forward" }}>{bodyText}</p>
          </div>
        </div>

        <div className="people-right">
          <img src={bodyImage} alt="people" />
        </div>
      </div>
    </div>
  );
};

export default People;

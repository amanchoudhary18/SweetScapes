const express = require("express");
const router = express.Router();
require("dotenv").config({ path: "../.env" });
const userAuth = require("../middleware/userAuth");
const adminAuth = require("../middleware/adminAuth");
const PlanController = require("../controllers/plan.controller");
const superAuth = require("../middleware/superAdminAuth");

// Get co-ordinates of a component
router.post("/getMap", PlanController.getMap);

// Add a new bus
router.post("/addBus", PlanController.addBus);

// Add a new outing
router.post("/addOuting", PlanController.addOuting);

// Add a new dining
router.post("/addDining", PlanController.addDining);

// Get number of dinings
router.get("/getDiningsLength", PlanController.getDiningsLength);

// Get number of outings
router.get("/getOutingsLength", PlanController.getOutingsLength);

// Get all dinings
router.get("/getDinings", PlanController.getAllDinings);

// Get all outings
router.get("/getOutings", PlanController.getAllOutings);

// Create travel options - using open map
router.post("/checkCreatePlan", PlanController.getOpenTravelOptions);

// Create travel options - using google map
router.post("/createPlan", PlanController.getGoogleTravelOptions);

// Save a plan
router.post("/savePlan", adminAuth, PlanController.savePlan);

// Get all plans
router.get("/getAllPlans", userAuth, PlanController.getAllPlans);

// Get all plans component names
router.get("/getAllPlansAdmin", adminAuth, PlanController.getAllPlansAdmin);

// Get plan by id
router.get("/getPlanDetails/:id", userAuth, PlanController.getParticularPlan);

// Get component by tags
router.post("/getComponentsByTag", userAuth, PlanController.getComponentsByTag);

// Save user created plan
router.post(
  "/saveUserCreatedPlan",
  userAuth,
  PlanController.saveUserCreatedPlan
);

// Get saved user created plan
router.get(
  "/getSavedUserCreatedPlan/:id",
  userAuth,
  PlanController.getSavedUserCreatedPlan
);

router.post("/approvePlan/:id", superAuth, PlanController.approvePlan);

router.get(
  "/searchRestaurant/:restaurantName",
  PlanController.searchRestaurant
);

module.exports = router;

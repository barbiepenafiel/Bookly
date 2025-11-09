const express = require("express");
const Stripe = require("stripe");
const router = express.Router();

// Initialize Stripe with secret key
const stripe = new Stripe(process.env.STRIPE_SECRET_KEY);

// Create payment intent
router.post("/create-payment-intent", async (req, res) => {
  try {
    const { amount, currency, items } = req.body;

    // Validate required fields
    if (!amount || !currency || !items) {
      return res.status(400).json({
        success: false,
        error: "Missing required fields: amount, currency, items",
      });
    }

    // Convert amount to cents (Stripe expects amounts in the smallest currency unit)
    const amountInCents = Math.round(amount * 100);

    // Create payment intent
    const paymentIntent = await stripe.paymentIntents.create({
      amount: amountInCents,
      currency: currency.toLowerCase(),
      automatic_payment_methods: {
        enabled: true,
      },
      metadata: {
        items: JSON.stringify(items),
      },
    });

    res.json({
      success: true,
      data: {
        client_secret: paymentIntent.client_secret,
        id: paymentIntent.id,
        amount: paymentIntent.amount,
        currency: paymentIntent.currency,
      },
    });
  } catch (error) {
    console.error("Payment intent creation error:", error);
    res.status(500).json({
      success: false,
      error: error.message || "Failed to create payment intent",
    });
  }
});

module.exports = router;

require("dotenv").config();
const express = require("express");
const cors = require("cors");
const authRoutes = require("./routes/auth");
const bookRoutes = require("./routes/books");
const paymentRoutes = require("./routes/payment");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Request logging middleware
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// Routes
app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "Welcome to Bookstore API",
    version: "1.0.0",
    endpoints: {
      auth: {
        register: "POST /auth/register",
        login: "POST /auth/login",
        profile: "GET /auth/profile",
      },
      books: {
        getAllBooks: "GET /books",
        getBookById: "GET /books/:id",
        getBooksByCategory: "GET /books/category/:category",
        createBook: "POST /books",
        updateBook: "PUT /books/:id",
        deleteBook: "DELETE /books/:id",
      },
      payment: {
        createPaymentIntent: "POST /payment/create-payment-intent",
      },
    },
  });
});

app.use("/auth", authRoutes);
app.use("/books", bookRoutes);
app.use("/payment", paymentRoutes);

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: "Route not found",
  });
});

// Error handler
app.use((err, req, res, next) => {
  console.error("Error:", err);
  res.status(500).json({
    success: false,
    message: "Internal server error",
    error: process.env.NODE_ENV === "development" ? err.message : undefined,
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`
🚀 Bookstore API Server is running!
📍 Port: ${PORT}
🌐 URL: http://localhost:${PORT}
📚 Environment: ${process.env.NODE_ENV || "development"}
  `);
});

module.exports = app;

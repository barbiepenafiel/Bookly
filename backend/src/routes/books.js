const express = require("express");
const {
  getAllBooks,
  getBookById,
  createBook,
  updateBook,
  deleteBook,
  getBooksByCategory,
} = require("../controllers/bookController");
const authMiddleware = require("../middleware/auth");

const router = express.Router();

// Public routes
router.get("/", getAllBooks);
router.get("/:id", getBookById);
router.get("/category/:category", getBooksByCategory);

// Protected routes (require authentication)
router.post("/", authMiddleware, createBook);
router.put("/:id", authMiddleware, updateBook);
router.delete("/:id", authMiddleware, deleteBook);

module.exports = router;

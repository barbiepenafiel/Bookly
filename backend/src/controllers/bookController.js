const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

// Get all books
const getAllBooks = async (req, res) => {
  try {
    const { category, search } = req.query;

    // Build where clause for filtering
    const where = {};

    if (category) {
      where.category = category;
    }

    if (search) {
      where.OR = [
        { title: { contains: search, mode: "insensitive" } },
        { author: { contains: search, mode: "insensitive" } },
      ];
    }

    const books = await prisma.book.findMany({
      where,
      orderBy: {
        createdAt: "desc",
      },
    });

    res.status(200).json({
      success: true,
      count: books.length,
      data: books,
    });
  } catch (error) {
    console.error("Get books error:", error);
    res.status(500).json({
      success: false,
      message: "Error fetching books",
      error: error.message,
    });
  }
};

// Get single book by ID
const getBookById = async (req, res) => {
  try {
    const { id } = req.params;

    const book = await prisma.book.findUnique({
      where: { id },
    });

    if (!book) {
      return res.status(404).json({
        success: false,
        message: "Book not found",
      });
    }

    res.status(200).json({
      success: true,
      data: book,
    });
  } catch (error) {
    console.error("Get book error:", error);
    res.status(500).json({
      success: false,
      message: "Error fetching book",
      error: error.message,
    });
  }
};

// Create a new book
const createBook = async (req, res) => {
  try {
    const {
      title,
      author,
      price,
      category,
      description,
      imageUrl,
      rating,
      reviews,
    } = req.body;

    // Validation
    if (!title || !author || !price || !category || !description) {
      return res.status(400).json({
        success: false,
        message:
          "Please provide title, author, price, category, and description",
      });
    }

    const book = await prisma.book.create({
      data: {
        title,
        author,
        price: parseFloat(price),
        category,
        description,
        imageUrl,
        rating: rating ? parseFloat(rating) : 4.0,
        reviews: reviews ? parseInt(reviews) : 0,
      },
    });

    res.status(201).json({
      success: true,
      message: "Book created successfully",
      data: book,
    });
  } catch (error) {
    console.error("Create book error:", error);
    res.status(500).json({
      success: false,
      message: "Error creating book",
      error: error.message,
    });
  }
};

// Update a book
const updateBook = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      title,
      author,
      price,
      category,
      description,
      imageUrl,
      rating,
      reviews,
    } = req.body;

    const book = await prisma.book.update({
      where: { id },
      data: {
        ...(title && { title }),
        ...(author && { author }),
        ...(price && { price: parseFloat(price) }),
        ...(category && { category }),
        ...(description && { description }),
        ...(imageUrl && { imageUrl }),
        ...(rating && { rating: parseFloat(rating) }),
        ...(reviews !== undefined && { reviews: parseInt(reviews) }),
      },
    });

    res.status(200).json({
      success: true,
      message: "Book updated successfully",
      data: book,
    });
  } catch (error) {
    console.error("Update book error:", error);
    res.status(500).json({
      success: false,
      message: "Error updating book",
      error: error.message,
    });
  }
};

// Delete a book
const deleteBook = async (req, res) => {
  try {
    const { id } = req.params;

    await prisma.book.delete({
      where: { id },
    });

    res.status(200).json({
      success: true,
      message: "Book deleted successfully",
    });
  } catch (error) {
    console.error("Delete book error:", error);
    res.status(500).json({
      success: false,
      message: "Error deleting book",
      error: error.message,
    });
  }
};

// Get books by category
const getBooksByCategory = async (req, res) => {
  try {
    const { category } = req.params;

    const books = await prisma.book.findMany({
      where: {
        category: {
          equals: category,
          mode: "insensitive",
        },
      },
      orderBy: {
        rating: "desc",
      },
    });

    res.status(200).json({
      success: true,
      count: books.length,
      data: books,
    });
  } catch (error) {
    console.error("Get books by category error:", error);
    res.status(500).json({
      success: false,
      message: "Error fetching books by category",
      error: error.message,
    });
  }
};

module.exports = {
  getAllBooks,
  getBookById,
  createBook,
  updateBook,
  deleteBook,
  getBooksByCategory,
};

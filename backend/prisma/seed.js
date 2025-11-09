const { PrismaClient } = require("@prisma/client");
const bcrypt = require("bcrypt");

const prisma = new PrismaClient();

async function main() {
  console.log("🌱 Seeding database...");

  // Create sample users
  const hashedPassword = await bcrypt.hash("password123", 10);

  const user1 = await prisma.user.upsert({
    where: { email: "john@example.com" },
    update: {},
    create: {
      email: "john@example.com",
      name: "John Doe",
      password: hashedPassword,
    },
  });

  const user2 = await prisma.user.upsert({
    where: { email: "jane@example.com" },
    update: {},
    create: {
      email: "jane@example.com",
      name: "Jane Smith",
      password: hashedPassword,
    },
  });

  const charlsPassword = await bcrypt.hash("charls123", 10);

  const user3 = await prisma.user.upsert({
    where: { email: "charlsrebaja@gmail.com" },
    update: {},
    create: {
      email: "charlsrebaja@gmail.com",
      name: "Charls Rebaja",
      password: charlsPassword,
    },
  });

  console.log("✅ Created users:", { user1, user2, user3 });

  // Create sample books grouped by category from CategoryPage
  const books = [
    // Fiction Category
    {
      title: "The Great Gatsby",
      author: "F. Scott Fitzgerald",
      price: 12.99,
      category: "Fiction",
      description:
        "A classic American novel set in the Jazz Age, exploring themes of wealth, love, and the American Dream.",
      imageUrl: "https://example.com/great-gatsby.jpg",
      rating: 4.7,
      reviews: 324,
    },
    {
      title: "To Kill a Mockingbird",
      author: "Harper Lee",
      price: 14.99,
      category: "Fiction",
      description:
        "A powerful story of racial injustice and childhood innocence in the American South.",
      imageUrl: "https://example.com/mockingbird.jpg",
      rating: 4.8,
      reviews: 512,
    },
    {
      title: "Pride and Prejudice",
      author: "Jane Austen",
      price: 11.99,
      category: "Fiction",
      description:
        "A romantic novel of manners that follows the character development of Elizabeth Bennet.",
      imageUrl: "https://example.com/pride-prejudice.jpg",
      rating: 4.6,
      reviews: 289,
    },
    {
      title: "The Catcher in the Rye",
      author: "J.D. Salinger",
      price: 13.99,
      category: "Fiction",
      description:
        "A story about teenage rebellion and alienation told by the protagonist Holden Caulfield.",
      imageUrl: "https://example.com/catcher-rye.jpg",
      rating: 4.4,
      reviews: 234,
    },

    // Science Fiction Category
    {
      title: "1984",
      author: "George Orwell",
      price: 15.99,
      category: "Science Fiction",
      description:
        "A dystopian social science fiction novel and cautionary tale about totalitarianism.",
      imageUrl: "https://example.com/1984.jpg",
      rating: 4.9,
      reviews: 678,
    },
    {
      title: "Dune",
      author: "Frank Herbert",
      price: 16.49,
      category: "Science Fiction",
      description:
        "A science fiction novel set in the distant future amidst a huge interstellar empire.",
      imageUrl: "https://example.com/dune.jpg",
      rating: 4.8,
      reviews: 987,
    },
    {
      title: "The Left Hand of Darkness",
      author: "Ursula K. Le Guin",
      price: 14.99,
      category: "Science Fiction",
      description:
        "A groundbreaking science fiction novel exploring gender and society on an alien world.",
      imageUrl: "https://example.com/left-hand-darkness.jpg",
      rating: 4.7,
      reviews: 445,
    },
    {
      title: "Neuromancer",
      author: "William Gibson",
      price: 15.49,
      category: "Science Fiction",
      description:
        "A cyberpunk novel that defined the genre and introduced the concept of cyberspace.",
      imageUrl: "https://example.com/neuromancer.jpg",
      rating: 4.6,
      reviews: 312,
    },

    // Fantasy Category
    {
      title: "The Hobbit",
      author: "J.R.R. Tolkien",
      price: 13.49,
      category: "Fantasy",
      description:
        "A fantasy adventure novel about the hobbit Bilbo Baggins journey to win treasure.",
      imageUrl: "https://example.com/hobbit.jpg",
      rating: 4.9,
      reviews: 1234,
    },
    {
      title: "Wuthering Heights",
      author: "Emily Brontë",
      price: 12.99,
      category: "Fantasy",
      description:
        "A dark romance set on the Yorkshire moors with supernatural elements and passionate drama.",
      imageUrl: "https://example.com/wuthering-heights.jpg",
      rating: 4.5,
      reviews: 267,
    },
    {
      title: "Jane Eyre",
      author: "Charlotte Brontë",
      price: 12.99,
      category: "Fantasy",
      description:
        "A novel that follows the experiences of its eponymous heroine, including her growth to adulthood.",
      imageUrl: "https://example.com/jane-eyre.jpg",
      rating: 4.5,
      reviews: 198,
    },
    {
      title: "Foundation",
      author: "Isaac Asimov",
      price: 14.99,
      category: "Fantasy",
      description:
        "An epic science fiction saga about the foundation of a new galactic empire.",
      imageUrl: "https://example.com/foundation.jpg",
      rating: 4.8,
      reviews: 523,
    },
  ];

  console.log("✅ Creating sample books...");

  for (const book of books) {
    await prisma.book.create({
      data: book,
    });
  }

  console.log(
    "✅ Created 12 sample books (Fiction, Science Fiction, and Fantasy)"
  );
  console.log("🎉 Database seeding completed successfully!");
}

main()
  .catch((e) => {
    console.error("❌ Error seeding database:", e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

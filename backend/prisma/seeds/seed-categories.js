const { PrismaClient } = require("@prisma/client");

const prisma = new PrismaClient();

const booksData = [
  // FICTION (6 books)
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    price: 12.99,
    category: "Fiction",
    description: "A classic American novel set in the Jazz Age.",
    imageUrl: "assets/the-great-gatsby.jpg",
    rating: 4.5,
    reviews: 325,
  },
  {
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    price: 14.99,
    category: "Fiction",
    description: "A gripping tale of racial injustice and childhood innocence.",
    imageUrl: "assets/to-kill-a-mockingbird.jpg",
    rating: 4.8,
    reviews: 412,
  },
  {
    title: "Pride and Prejudice",
    author: "Jane Austen",
    price: 11.99,
    category: "Fiction",
    description:
      "A witty romantic novel of manners and marriage in Regency England.",
    imageUrl: "assets/pride-and-prejudice.jpg",
    rating: 4.7,
    reviews: 298,
  },
  {
    title: "The Catcher in the Rye",
    author: "J.D. Salinger",
    price: 13.99,
    category: "Fiction",
    description:
      "A controversial coming-of-age novel following Holden Caulfield.",
    imageUrl: "assets/the-catcher-in-the-rye.jpg",
    rating: 4.2,
    reviews: 267,
  },
  {
    title: "1984",
    author: "George Orwell",
    price: 15.99,
    category: "Fiction",
    description:
      "A dystopian masterpiece exploring totalitarianism and surveillance.",
    imageUrl: "assets/1984.jpg",
    rating: 4.6,
    reviews: 389,
  },
  {
    title: "Jane Eyre",
    author: "Charlotte Brontë",
    price: 12.99,
    category: "Fiction",
    description:
      "A gothic romance and feminist novel of independence and passion.",
    imageUrl: "assets/jane-eyre.jpg",
    rating: 4.5,
    reviews: 276,
  },

  // ROMANCE (6 books)
  {
    title: "Pride and Prejudice",
    author: "Jane Austen",
    price: 11.99,
    category: "Romance",
    description:
      "A witty romantic novel of manners and marriage in Regency England.",
    imageUrl: "assets/pride-and-prejudice.jpg",
    rating: 4.7,
    reviews: 298,
  },
  {
    title: "Jane Eyre",
    author: "Charlotte Brontë",
    price: 12.99,
    category: "Romance",
    description:
      "A gothic romance and feminist novel of independence and passion.",
    imageUrl: "assets/jane-eyre.jpg",
    rating: 4.5,
    reviews: 276,
  },
  {
    title: "Wuthering Heights",
    author: "Emily Brontë",
    price: 13.99,
    category: "Romance",
    description:
      "A dark and passionate tale of love and revenge on the Yorkshire moors.",
    imageUrl: "assets/wuthering-heights.jpg",
    rating: 4.3,
    reviews: 234,
  },
  {
    title: "The Notebook",
    author: "Nicholas Sparks",
    price: 10.99,
    category: "Romance",
    description:
      "A touching love story that spans decades and transcends class.",
    imageUrl: "assets/the-notebook.jpg",
    rating: 4.4,
    reviews: 312,
  },
  {
    title: "Outlander",
    author: "Diana Gabaldon",
    price: 16.99,
    category: "Romance",
    description:
      "An epic time-traveling romance spanning centuries and continents.",
    imageUrl: "assets/outlander.jpg",
    rating: 4.6,
    reviews: 445,
  },
  {
    title: "The Time Traveler's Wife",
    author: "Audrey Niffenegger",
    price: 14.99,
    category: "Romance",
    description:
      "A romantic tale of a man who involuntarily travels through time.",
    imageUrl: "assets/the-time-travelers-wife.jpg",
    rating: 4.5,
    reviews: 287,
  },

  // SCI-FI (6 books)
  {
    title: "Dune",
    author: "Frank Herbert",
    price: 17.99,
    category: "Sci-Fi",
    description:
      "An epic space opera on a desert planet with politics and mysticism.",
    imageUrl: "assets/dune.jpg",
    rating: 4.7,
    reviews: 356,
  },
  {
    title: "1984",
    author: "George Orwell",
    price: 15.99,
    category: "Sci-Fi",
    description:
      "A dystopian masterpiece exploring totalitarianism and surveillance.",
    imageUrl: "assets/1984.jpg",
    rating: 4.6,
    reviews: 389,
  },
  {
    title: "Foundation",
    author: "Isaac Asimov",
    price: 14.99,
    category: "Sci-Fi",
    description:
      "A groundbreaking series about the fall and rise of galactic civilization.",
    imageUrl: "assets/foundation.jpg",
    rating: 4.5,
    reviews: 301,
  },
  {
    title: "Neuromancer",
    author: "William Gibson",
    price: 13.99,
    category: "Sci-Fi",
    description:
      "The cyberpunk novel that defined a genre and predicted the internet.",
    imageUrl: "assets/neuromancer.jpg",
    rating: 4.3,
    reviews: 198,
  },
  {
    title: "The Left Hand of Darkness",
    author: "Ursula K. Le Guin",
    price: 12.99,
    category: "Sci-Fi",
    description: "A groundbreaking exploration of gender and alien cultures.",
    imageUrl: "assets/the-left-hand-of-darkness.jpg",
    rating: 4.4,
    reviews: 267,
  },
  {
    title: "Ender's Game",
    author: "Orson Scott Card",
    price: 13.99,
    category: "Sci-Fi",
    description:
      "A thought-provoking military sci-fi exploring war and morality.",
    imageUrl: "assets/enders-game.jpg",
    rating: 4.6,
    reviews: 334,
  },

  // MYSTERY (6 books)
  {
    title: "Murder on the Orient Express",
    author: "Agatha Christie",
    price: 11.99,
    category: "Mystery",
    description: "A classic locked-room mystery on a luxury train.",
    imageUrl: "assets/murder-on-the-orient-express.jpg",
    rating: 4.6,
    reviews: 289,
  },
  {
    title: "The Girl with the Dragon Tattoo",
    author: "Stieg Larsson",
    price: 15.99,
    category: "Mystery",
    description: "A gripping Nordic noir mystery with complex characters.",
    imageUrl: "assets/the-girl-with-the-dragon-tattoo.jpg",
    rating: 4.5,
    reviews: 401,
  },
  {
    title: "And Then There Were None",
    author: "Agatha Christie",
    price: 12.99,
    category: "Mystery",
    description:
      "Ten strangers are invited to an island where they are accused of crimes.",
    imageUrl: "assets/and-then-there-were-none.jpg",
    rating: 4.7,
    reviews: 356,
  },
  {
    title: "The Maltese Falcon",
    author: "Dashiell Hammett",
    price: 10.99,
    category: "Mystery",
    description: "A hardboiled detective classic featuring Sam Spade.",
    imageUrl: "assets/the-maltese-falcon.jpg",
    rating: 4.4,
    reviews: 201,
  },
  {
    title: "Rebecca",
    author: "Daphne du Maurier",
    price: 13.99,
    category: "Mystery",
    description: "A gothic mystery of suspicion, jealousy, and secrets.",
    imageUrl: "assets/rebecca.jpg",
    rating: 4.6,
    reviews: 312,
  },
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    price: 12.99,
    category: "Mystery",
    description:
      "A classic American novel with mysterious characters and motives.",
    imageUrl: "assets/the-great-gatsby.jpg",
    rating: 4.5,
    reviews: 325,
  },

  // BIOGRAPHY (6 books)
  {
    title: "Steve Jobs",
    author: "Walter Isaacson",
    price: 18.99,
    category: "Biography",
    description: "An authorized biography of the Apple founder and visionary.",
    imageUrl: "assets/steve-jobs.jpg",
    rating: 4.5,
    reviews: 423,
  },
  {
    title: "The Diary of Anne Frank",
    author: "Anne Frank",
    price: 12.99,
    category: "Biography",
    description:
      "A powerful first-hand account of hiding during the Holocaust.",
    imageUrl: "assets/the-diary-of-anne-frank.jpg",
    rating: 4.8,
    reviews: 512,
  },
  {
    title: "Becoming",
    author: "Michelle Obama",
    price: 19.99,
    category: "Biography",
    description: "The memoir of the former First Lady of the United States.",
    imageUrl: "assets/becoming.jpg",
    rating: 4.7,
    reviews: 456,
  },
  {
    title: "I Am Malala",
    author: "Malala Yousafzai",
    price: 16.99,
    category: "Biography",
    description:
      "The inspiring story of a Nobel Prize winner fighting for education.",
    imageUrl: "assets/i-am-malala.jpg",
    rating: 4.6,
    reviews: 378,
  },
  {
    title: "The Story of My Life",
    author: "Helen Keller",
    price: 9.99,
    category: "Biography",
    description:
      "An inspiring autobiography of overcoming disability and poverty.",
    imageUrl: "assets/the-story-of-my-life.jpg",
    rating: 4.5,
    reviews: 267,
  },
  {
    title: "Born to Run",
    author: "Christopher McDougall",
    price: 14.99,
    category: "Biography",
    description:
      "A fascinating exploration of running, endurance, and human potential.",
    imageUrl: "assets/born-to-run.jpg",
    rating: 4.4,
    reviews: 289,
  },

  // HISTORY (6 books)
  {
    title: "The Guns of August",
    author: "Barbara W. Tuchman",
    price: 16.99,
    category: "History",
    description:
      "A Pulitzer Prize-winning account of the opening of World War I.",
    imageUrl: "assets/the-guns-of-august.jpg",
    rating: 4.6,
    reviews: 267,
  },
  {
    title: "A Brief History of Time",
    author: "Stephen Hawking",
    price: 15.99,
    category: "History",
    description:
      "From the Big Bang to Black Holes - a journey through space and time.",
    imageUrl: "assets/a-brief-history-of-time.jpg",
    rating: 4.3,
    reviews: 312,
  },
  {
    title: "Sapiens",
    author: "Yuval Noah Harari",
    price: 18.99,
    category: "History",
    description:
      "A sweeping history of humankind from the Stone Age to modern times.",
    imageUrl: "assets/sapiens.jpg",
    rating: 4.6,
    reviews: 487,
  },
  {
    title: "The Rise and Fall of the Third Reich",
    author: "William Shirer",
    price: 19.99,
    category: "History",
    description: "A comprehensive history of Nazi Germany during World War II.",
    imageUrl: "assets/the-rise-and-fall-of-the-third-reich.jpg",
    rating: 4.7,
    reviews: 334,
  },
  {
    title: "1491",
    author: "Charles C. Mann",
    price: 17.99,
    category: "History",
    description:
      "A revolutionary look at pre-Columbian America and its impact.",
    imageUrl: "assets/1491.jpg",
    rating: 4.5,
    reviews: 278,
  },
  {
    title: "The Code Breaker",
    author: "Walter Isaacson",
    price: 18.99,
    category: "History",
    description:
      "The inspiring biography of Jennifer Doudna and the gene-editing revolution.",
    imageUrl: "assets/the-code-breaker.jpg",
    rating: 4.5,
    reviews: 256,
  },
];

async function main() {
  console.log("🌱 Starting database seed with 36 books (6 per category)...");

  try {
    // Optional: Delete all existing books first
    // await prisma.book.deleteMany({});
    // console.log('🗑️  Deleted existing books');

    // Create all books
    for (const book of booksData) {
      const created = await prisma.book.create({
        data: book,
      });
      console.log(`✅ Created: "${created.title}" (${created.category})`);
    }

    console.log("✨ Seed completed successfully!");
    console.log(`📚 Total books added: ${booksData.length}`);
    console.log("📊 Distribution: 6 books per category");
  } catch (error) {
    console.error("❌ Seeding failed:", error);
    process.exit(1);
  } finally {
    await prisma.$disconnect();
  }
}

main();

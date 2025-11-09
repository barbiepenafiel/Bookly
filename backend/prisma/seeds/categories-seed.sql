-- Seed file for populating books table with 36 books (6 per category)
-- This script adds all books for Fiction, Romance, Sci-Fi, Mystery, Biography, and History categories

-- Clear existing books (optional - comment out if you want to preserve existing data)
-- TRUNCATE TABLE books;

-- FICTION (6 books)
INSERT INTO books (id, title, author, price, category, description, image_url, rating, reviews, "createdAt")
VALUES 
  (gen_random_uuid(), 'The Great Gatsby', 'F. Scott Fitzgerald', 12.99, 'Fiction', 'A classic American novel set in the Jazz Age.', 'assets/the-great-gatsby.jpg', 4.5, 325, NOW()),
  (gen_random_uuid(), 'To Kill a Mockingbird', 'Harper Lee', 14.99, 'Fiction', 'A gripping tale of racial injustice and childhood innocence.', 'assets/to-kill-a-mockingbird.jpg', 4.8, 412, NOW()),
  (gen_random_uuid(), 'Pride and Prejudice', 'Jane Austen', 11.99, 'Fiction', 'A witty romantic novel of manners and marriage in Regency England.', 'assets/pride-and-prejudice.jpg', 4.7, 298, NOW()),
  (gen_random_uuid(), 'The Catcher in the Rye', 'J.D. Salinger', 13.99, 'Fiction', 'A controversial coming-of-age novel following Holden Caulfield.', 'assets/the-catcher-in-the-rye.jpg', 4.2, 267, NOW()),
  (gen_random_uuid(), '1984', 'George Orwell', 15.99, 'Fiction', 'A dystopian masterpiece exploring totalitarianism and surveillance.', 'assets/1984.jpg', 4.6, 389, NOW()),
  (gen_random_uuid(), 'Jane Eyre', 'Charlotte Brontë', 12.99, 'Fiction', 'A gothic romance and feminist novel of independence and passion.', 'assets/jane-eyre.jpg', 4.5, 276, NOW());

-- ROMANCE (6 books)
INSERT INTO books (id, title, author, price, category, description, image_url, rating, reviews, "createdAt")
VALUES 
  (gen_random_uuid(), 'Pride and Prejudice', 'Jane Austen', 11.99, 'Romance', 'A witty romantic novel of manners and marriage in Regency England.', 'assets/pride-and-prejudice.jpg', 4.7, 298, NOW()),
  (gen_random_uuid(), 'Jane Eyre', 'Charlotte Brontë', 12.99, 'Romance', 'A gothic romance and feminist novel of independence and passion.', 'assets/jane-eyre.jpg', 4.5, 276, NOW()),
  (gen_random_uuid(), 'Wuthering Heights', 'Emily Brontë', 13.99, 'Romance', 'A dark and passionate tale of love and revenge on the Yorkshire moors.', 'assets/wuthering-heights.jpg', 4.3, 234, NOW()),
  (gen_random_uuid(), 'The Notebook', 'Nicholas Sparks', 10.99, 'Romance', 'A touching love story that spans decades and transcends class.', 'assets/the-notebook.jpg', 4.4, 312, NOW()),
  (gen_random_uuid(), 'Outlander', 'Diana Gabaldon', 16.99, 'Romance', 'An epic time-traveling romance spanning centuries and continents.', 'assets/outlander.jpg', 4.6, 445, NOW()),
  (gen_random_uuid(), 'The Time Traveler''s Wife', 'Audrey Niffenegger', 14.99, 'Romance', 'A romantic tale of a man who involuntarily travels through time.', 'assets/the-time-travelers-wife.jpg', 4.5, 287, NOW());

-- SCI-FI (6 books)
INSERT INTO books (id, title, author, price, category, description, image_url, rating, reviews, "createdAt")
VALUES 
  (gen_random_uuid(), 'Dune', 'Frank Herbert', 17.99, 'Sci-Fi', 'An epic space opera on a desert planet with politics and mysticism.', 'assets/dune.jpg', 4.7, 356, NOW()),
  (gen_random_uuid(), '1984', 'George Orwell', 15.99, 'Sci-Fi', 'A dystopian masterpiece exploring totalitarianism and surveillance.', 'assets/1984.jpg', 4.6, 389, NOW()),
  (gen_random_uuid(), 'Foundation', 'Isaac Asimov', 14.99, 'Sci-Fi', 'A groundbreaking series about the fall and rise of galactic civilization.', 'assets/foundation.jpg', 4.5, 301, NOW()),
  (gen_random_uuid(), 'Neuromancer', 'William Gibson', 13.99, 'Sci-Fi', 'The cyberpunk novel that defined a genre and predicted the internet.', 'assets/neuromancer.jpg', 4.3, 198, NOW()),
  (gen_random_uuid(), 'The Left Hand of Darkness', 'Ursula K. Le Guin', 12.99, 'Sci-Fi', 'A groundbreaking exploration of gender and alien cultures.', 'assets/the-left-hand-of-darkness.jpg', 4.4, 267, NOW()),
  (gen_random_uuid(), 'Ender''s Game', 'Orson Scott Card', 13.99, 'Sci-Fi', 'A thought-provoking military sci-fi exploring war and morality.', 'assets/enders-game.jpg', 4.6, 334, NOW());

-- MYSTERY (6 books)
INSERT INTO books (id, title, author, price, category, description, image_url, rating, reviews, "createdAt")
VALUES 
  (gen_random_uuid(), 'Murder on the Orient Express', 'Agatha Christie', 11.99, 'Mystery', 'A classic locked-room mystery on a luxury train.', 'assets/murder-on-the-orient-express.jpg', 4.6, 289, NOW()),
  (gen_random_uuid(), 'The Girl with the Dragon Tattoo', 'Stieg Larsson', 15.99, 'Mystery', 'A gripping Nordic noir mystery with complex characters.', 'assets/the-girl-with-the-dragon-tattoo.jpg', 4.5, 401, NOW()),
  (gen_random_uuid(), 'And Then There Were None', 'Agatha Christie', 12.99, 'Mystery', 'Ten strangers are invited to an island where they are accused of crimes.', 'assets/and-then-there-were-none.jpg', 4.7, 356, NOW()),
  (gen_random_uuid(), 'The Maltese Falcon', 'Dashiell Hammett', 10.99, 'Mystery', 'A hardboiled detective classic featuring Sam Spade.', 'assets/the-maltese-falcon.jpg', 4.4, 201, NOW()),
  (gen_random_uuid(), 'Rebecca', 'Daphne du Maurier', 13.99, 'Mystery', 'A gothic mystery of suspicion, jealousy, and secrets.', 'assets/rebecca.jpg', 4.6, 312, NOW()),
  (gen_random_uuid(), 'The Great Gatsby', 'F. Scott Fitzgerald', 12.99, 'Mystery', 'A classic American novel with mysterious characters and motives.', 'assets/the-great-gatsby.jpg', 4.5, 325, NOW());

-- BIOGRAPHY (6 books)
INSERT INTO books (id, title, author, price, category, description, image_url, rating, reviews, "createdAt")
VALUES 
  (gen_random_uuid(), 'Steve Jobs', 'Walter Isaacson', 18.99, 'Biography', 'An authorized biography of the Apple founder and visionary.', 'assets/steve-jobs.jpg', 4.5, 423, NOW()),
  (gen_random_uuid(), 'The Diary of Anne Frank', 'Anne Frank', 12.99, 'Biography', 'A powerful first-hand account of hiding during the Holocaust.', 'assets/the-diary-of-anne-frank.jpg', 4.8, 512, NOW()),
  (gen_random_uuid(), 'Becoming', 'Michelle Obama', 19.99, 'Biography', 'The memoir of the former First Lady of the United States.', 'assets/becoming.jpg', 4.7, 456, NOW()),
  (gen_random_uuid(), 'I Am Malala', 'Malala Yousafzai', 16.99, 'Biography', 'The inspiring story of a Nobel Prize winner fighting for education.', 'assets/i-am-malala.jpg', 4.6, 378, NOW()),
  (gen_random_uuid(), 'The Story of My Life', 'Helen Keller', 9.99, 'Biography', 'An inspiring autobiography of overcoming disability and poverty.', 'assets/the-story-of-my-life.jpg', 4.5, 267, NOW()),
  (gen_random_uuid(), 'Born to Run', 'Christopher McDougall', 14.99, 'Biography', 'A fascinating exploration of running, endurance, and human potential.', 'assets/born-to-run.jpg', 4.4, 289, NOW());

-- HISTORY (6 books)
INSERT INTO books (id, title, author, price, category, description, image_url, rating, reviews, "createdAt")
VALUES 
  (gen_random_uuid(), 'The Guns of August', 'Barbara W. Tuchman', 16.99, 'History', 'A Pulitzer Prize-winning account of the opening of World War I.', 'assets/the-guns-of-august.jpg', 4.6, 267, NOW()),
  (gen_random_uuid(), 'A Brief History of Time', 'Stephen Hawking', 15.99, 'History', 'From the Big Bang to Black Holes - a journey through space and time.', 'assets/a-brief-history-of-time.jpg', 4.3, 312, NOW()),
  (gen_random_uuid(), 'Sapiens', 'Yuval Noah Harari', 18.99, 'History', 'A sweeping history of humankind from the Stone Age to modern times.', 'assets/sapiens.jpg', 4.6, 487, NOW()),
  (gen_random_uuid(), 'The Rise and Fall of the Third Reich', 'William Shirer', 19.99, 'History', 'A comprehensive history of Nazi Germany during World War II.', 'assets/the-rise-and-fall-of-the-third-reich.jpg', 4.7, 334, NOW()),
  (gen_random_uuid(), '1491', 'Charles C. Mann', 17.99, 'History', 'A revolutionary look at pre-Columbian America and its impact.', 'assets/1491.jpg', 4.5, 278, NOW()),
  (gen_random_uuid(), 'The Code Breaker', 'Walter Isaacson', 18.99, 'History', 'The inspiring biography of Jennifer Doudna and the gene-editing revolution.', 'assets/the-code-breaker.jpg', 4.5, 256, NOW());

Act as a Senior Full Stack Developer (Node.js, Prisma, and Flutter expert).

Add into my Bookstore App that includes working pages for login, registration, homepage, and book details. However, these pages are not yet connected to any backend or database.

I want you to help me build and integrate a backend system using Node.js + Express.js with Prisma ORM, connected to my NeonDB PostgreSQL database. The backend will handle user authentication and store all book data, which will then be fetched and displayed dynamically in my Flutter app.

🧩 Tech Stack Requirements

Backend Framework: Node.js with Express.js

ORM: Prisma (for schema definition, migration, and database management)

Database: NeonDB (PostgreSQL)

Frontend: Existing Flutter Bookstore App

Authentication: JWT (JSON Web Token) for login and user sessions

Password Security: bcrypt for password hashing

Environment Variables: dotenv for configuration management

⚙️ Backend Setup Instructions

Initialize a Node.js backend project specifically for the Bookstore system.

Install all required dependencies for Express, Prisma, JWT authentication, password hashing, and environment configuration.

Create a proper folder structure that separates concerns, including folders for routes, controllers, and Prisma schema management.

Configure the .env file to store environment variables such as the server port, database connection string (from NeonDB), and JWT secret key.

Connect Prisma to my NeonDB PostgreSQL database using the DATABASE_URL environment variable.

Database Connection Example in .env:
DATABASE_URL='postgresql://neondb_owner:npg_PhuXd3Uwet8Y@ep-snowy-forest-a1izjr99-pooler.ap-southeast-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require'

🧱 Database Schema Design (Prisma)

Define a clear Prisma schema that includes at least two main models:

User Model for authentication:

Fields: ID, name, email, password, and createdAt timestamp.

Email should be unique.

Passwords must be securely hashed before storing.

Book Model for storing all book-related information:

Fields: ID, title, author, price, category, description, image URL, and createdAt timestamp.

Once the models are defined, generate and apply Prisma migrations to NeonDB to automatically create the corresponding database tables.

🧠 Backend Functionality to Implement

User Authentication:

Implement user registration that securely stores user credentials in NeonDB.

Implement user login that validates credentials, generates a JWT token, and returns it upon successful authentication.

Ensure passwords are hashed using bcrypt and tokens are generated using JWT.

Book Management:

Create routes and controllers to fetch all books, fetch a single book by ID, and add new books.

Ensure that data is read and written from NeonDB through Prisma.

The /books endpoint should return book data in JSON format so Flutter can display it dynamically.

API Structure:

All routes should follow RESTful conventions (e.g., /auth/register, /auth/login, /books).

Include error handling for all API responses.

Use Express middleware for JSON parsing and CORS support.

📦 Prisma Integration and Migration

Initialize Prisma in the project.

Update the Prisma schema file with the User and Book models.

Use the Prisma migration command to push schema changes and create tables in NeonDB.

Generate the Prisma client for database access.

Optionally, set up a Prisma seed file that automatically inserts a few sample book entries (for example, "Atomic Habits" or "The Alchemist") to verify that the connection and migration work properly.

🔐 Authentication Details

When users register, their password should be hashed before storage.

When users log in, their password should be validated using bcrypt.

Upon successful login, generate a JWT token that includes the user’s ID and expires after one hour.

Return this token to Flutter for future authenticated requests.

📱 Flutter Integration Instructions

Update the Flutter Login and Register pages to send POST requests to the backend endpoints using the http package.

On registration, send the user’s name, email, and password to the /auth/register endpoint.

On login, send the email and password to the /auth/login endpoint and store the received token locally (e.g., using shared preferences).

On the homepage, call the /books API endpoint to fetch all books dynamically and display them in the UI.

On the book details page, fetch a single book using the /books/:id endpoint to show full details.

🎯 Expected Deliverables

Fully working backend API connected to NeonDB via Prisma ORM.

Automatically migrated database schema with User and Book models.

Properly structured backend folder setup with routes, controllers, and Prisma configuration.

Secure authentication system using JWT and bcrypt.

Example seed data added to NeonDB via Prisma seeding script.

Flutter app successfully connected to the backend to register users, log in, and fetch books dynamically.

✅ Final Goal

After implementation, I should be able to:

Run the backend server and connect it directly to my NeonDB PostgreSQL database.

Automatically migrate the Prisma schema to NeonDB.

Register and log in users securely from my Flutter app.

Store and display book data dynamically from the NeonDB database.

Verify everything is working by fetching books and users directly from the API endpoints.

Focus on clean architecture, clear folder organization, and maintainable code following best practices for Node.js and Prisma.
The output should be a fully functional backend ready for integration with my Flutter Bookstore App using NeonDB as the database.

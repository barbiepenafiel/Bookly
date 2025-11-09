# Bookstore Backend API

A complete backend system for the Bookstore Flutter app built with Node.js, Express, Prisma ORM, and NeonDB PostgreSQL.

## 🚀 Tech Stack

- **Runtime**: Node.js
- **Framework**: Express.js
- **ORM**: Prisma
- **Database**: NeonDB (PostgreSQL)
- **Authentication**: JWT (JSON Web Tokens)
- **Password Hashing**: bcrypt
- **Environment Variables**: dotenv

## 📁 Project Structure

```
backend/
├── prisma/
│   ├── schema.prisma      # Database schema
│   └── seed.js           # Seed data
├── src/
│   ├── controllers/
│   │   ├── authController.js
│   │   └── bookController.js
│   ├── routes/
│   │   ├── auth.js
│   │   └── books.js
│   ├── middleware/
│   │   └── auth.js       # JWT middleware
│   └── server.js         # Main server file
├── .env                  # Environment variables
├── .gitignore
└── package.json
```

## ⚙️ Setup Instructions

### 1. Install Dependencies

```bash
cd backend
npm install
```

### 2. Configure Environment Variables

The `.env` file is already configured with your NeonDB connection string:

```env
PORT=3000
DATABASE_URL='postgresql://neondb_owner:npg_PhuXd3Uwet8Y@ep-snowy-forest-a1izjr99-pooler.ap-southeast-1.aws.neon.tech/neondb?sslmode=require&channel_binding=require'
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRES_IN=1h
```

### 3. Initialize Prisma and Database

```bash
# Generate Prisma Client
npx prisma generate

# Run migrations to create tables in NeonDB
npx prisma migrate dev --name init

# Seed the database with sample data
npm run prisma:seed
```

**Or run all setup steps at once:**

```bash
npm run setup
```

### 4. Start the Server

```bash
# Production mode
npm start

# Development mode (with nodemon - auto-restart)
npm run dev
```

Server will start at: **http://localhost:3000**

## 📚 API Endpoints

### Authentication

| Method | Endpoint         | Description       | Auth Required |
| ------ | ---------------- | ----------------- | ------------- |
| POST   | `/auth/register` | Register new user | No            |
| POST   | `/auth/login`    | Login user        | No            |
| GET    | `/auth/profile`  | Get user profile  | Yes           |

### Books

| Method | Endpoint                    | Description           | Auth Required |
| ------ | --------------------------- | --------------------- | ------------- |
| GET    | `/books`                    | Get all books         | No            |
| GET    | `/books/:id`                | Get single book       | No            |
| GET    | `/books/category/:category` | Get books by category | No            |
| POST   | `/books`                    | Create new book       | Yes           |
| PUT    | `/books/:id`                | Update book           | Yes           |
| DELETE | `/books/:id`                | Delete book           | Yes           |

## 🔐 Authentication

### Register User

```bash
POST /auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**

```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "id": "uuid",
    "name": "John Doe",
    "email": "john@example.com",
    "createdAt": "2025-11-07T..."
  }
}
```

### Login User

```bash
POST /auth/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**

```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": "uuid",
      "name": "John Doe",
      "email": "john@example.com"
    },
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### Get Profile (Protected)

```bash
GET /auth/profile
Authorization: Bearer <your-jwt-token>
```

## 📖 Book Endpoints

### Get All Books

```bash
GET /books
```

**Query Parameters (optional):**

- `category` - Filter by category
- `search` - Search in title and author

**Example:**

```bash
GET /books?category=Fiction
GET /books?search=gatsby
```

### Get Book by ID

```bash
GET /books/:id
```

### Create Book (Protected)

```bash
POST /books
Authorization: Bearer <your-jwt-token>
Content-Type: application/json

{
  "title": "New Book",
  "author": "Author Name",
  "price": 19.99,
  "category": "Fiction",
  "description": "Book description here",
  "imageUrl": "https://example.com/image.jpg",
  "rating": 4.5,
  "reviews": 100
}
```

## 🗄️ Database Models

### User Model

```prisma
model User {
  id        String   @id @default(uuid())
  name      String
  email     String   @unique
  password  String
  createdAt DateTime @default(now())
}
```

### Book Model

```prisma
model Book {
  id          String   @id @default(uuid())
  title       String
  author      String
  price       Float
  category    String
  description String
  imageUrl    String?
  rating      Float?   @default(4.0)
  reviews     Int?     @default(0)
  createdAt   DateTime @default(now())
}
```

## 🛠️ Prisma Commands

```bash
# Generate Prisma Client
npx prisma generate

# Create migration
npx prisma migrate dev --name migration_name

# Apply migrations
npx prisma migrate deploy

# Open Prisma Studio (GUI for database)
npx prisma studio

# Seed database
npm run prisma:seed

# Reset database (WARNING: Deletes all data)
npx prisma migrate reset
```

## 🧪 Sample Data

The seed file creates:

- 2 sample users (john@example.com / jane@example.com)
- 12 sample books from various categories
- Default password for sample users: `password123`

## 🔒 Security Features

- ✅ Password hashing with bcrypt (10 salt rounds)
- ✅ JWT token authentication
- ✅ Protected routes with middleware
- ✅ CORS enabled for Flutter app
- ✅ Environment variables for sensitive data
- ✅ Input validation

## 📱 Flutter Integration

### 1. Add HTTP Package

In your Flutter `pubspec.yaml`:

```yaml
dependencies:
  http: ^1.1.0
  shared_preferences: ^2.2.2
```

### 2. Create API Service

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  // Register
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'name': name, 'email': email, 'password': password}),
    );
    return json.decode(response.body);
  }

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    return json.decode(response.body);
  }

  // Get Books
  Future<List<dynamic>> getBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/books'));
    final data = json.decode(response.body);
    return data['data'];
  }
}
```

## 🚨 Troubleshooting

### Connection Issues

If you get connection errors:

1. Check if NeonDB connection string is correct
2. Verify your internet connection
3. Check if NeonDB server is accessible

### Migration Issues

```bash
# Reset and rerun migrations
npx prisma migrate reset
npx prisma migrate dev
npm run prisma:seed
```

### Port Already in Use

Change the PORT in `.env` file or kill the process:

```bash
# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Linux/Mac
lsof -i :3000
kill -9 <PID>
```

## 📝 Environment Variables Reference

| Variable         | Description              | Default     |
| ---------------- | ------------------------ | ----------- |
| `PORT`           | Server port              | 3000        |
| `NODE_ENV`       | Environment              | development |
| `DATABASE_URL`   | NeonDB connection string | (required)  |
| `JWT_SECRET`     | JWT secret key           | (required)  |
| `JWT_EXPIRES_IN` | Token expiration         | 1h          |

## ✅ Checklist

- [x] Backend project initialized
- [x] Dependencies installed
- [x] Prisma schema defined
- [x] Database migrations created
- [x] Sample data seeded
- [x] Authentication endpoints working
- [x] Book endpoints working
- [x] JWT authentication implemented
- [x] CORS configured
- [x] Error handling added
- [x] Ready for Flutter integration

## 🎯 Next Steps

1. ✅ Backend is ready and running
2. Update Flutter app to use this API
3. Test all endpoints with Postman or Flutter app
4. Deploy to production when ready

## 📞 API Testing with cURL

```bash
# Register
curl -X POST http://localhost:3000/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com","password":"password123"}'

# Login
curl -X POST http://localhost:3000/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'

# Get Books
curl http://localhost:3000/books
```

## 🌟 Features

- ✅ RESTful API architecture
- ✅ Secure authentication with JWT
- ✅ Password hashing with bcrypt
- ✅ Database ORM with Prisma
- ✅ PostgreSQL database (NeonDB)
- ✅ CORS enabled
- ✅ Error handling
- ✅ Request logging
- ✅ Sample data seeding
- ✅ Clean code structure

---

**Created with ❤️ for Bookstore Flutter App**

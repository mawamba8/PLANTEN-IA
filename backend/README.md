# PlantCare AI Backend

This backend provides authentication, diagnostic storage, and agricultural center access for the PlantCare AI Flutter app.

## Setup

1. Copy `.env.example` to `.env`
2. Update the PostgreSQL connection string
3. Install dependencies:

```bash
npm install
```

4. Generate Prisma client:

```bash
npx prisma generate
```

5. Run database migration:

```bash
npx prisma migrate dev --name init
```

6. Start the server:

```bash
npm run dev
```

## Main routes

- `POST /api/auth/register`
- `POST /api/auth/login`
- `GET /api/health`
- `POST /api/diagnostics`
- `GET /api/diagnostics`
- `GET /api/centers`

## Notes

This version provides the production-ready API foundation. The AI disease detection service will be implemented as a separate Python microservice.

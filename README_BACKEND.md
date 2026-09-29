# Backend PlantCare AI

## Structure

- backend/ : Node.js + Express + Prisma API
- ai-service/ : Python microservice for plant disease diagnosis

## Quick start

### 1) Install backend dependencies

```bash
cd backend
npm install
```

### 2) Configure PostgreSQL

Create a PostgreSQL database and update the `.env` file using `.env.example`.

### 3) Prisma

```bash
cd backend
npx prisma generate
npx prisma migrate dev --name init
```

### 4) Run backend

```bash
cd backend
npm run dev
```

### 5) Run AI service

```bash
cd ai-service
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```

## API summary

- `POST /api/auth/register`
- `POST /api/auth/login`
- `GET /api/health`
- `POST /api/diagnostics`
- `GET /api/diagnostics`
- `GET /api/centers`
- `POST /api/diagnose` in AI service

## Notes

This project currently uses a modular architecture with a dedicated Python vision service for diagnosis, while the Node API handles users, auth and storage.

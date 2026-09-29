import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import authRoutes from './routes/authRoutes.js';
import diagnosticRoutes from './routes/diagnosticRoutes.js';
import centerRoutes from './routes/centerRoutes.js';

dotenv.config();

const app = express();
const port = Number(process.env.PORT || 4000);
const host = process.env.HOST || '0.0.0.0';

app.use(cors());
app.use(express.json({ limit: '10mb' }));

app.get('/api/health', (req, res) => {
  res.json({ ok: true, message: 'PlantCare AI backend is running' });
});

app.use('/api/auth', authRoutes);
app.use('/api/diagnostics', diagnosticRoutes);
app.use('/api/centers', centerRoutes);

app.listen(port, host, () => {
  console.log(`PlantCare AI backend running on http://${host}:${port}`);
  console.log(`Also available on http://localhost:${port}`);
});

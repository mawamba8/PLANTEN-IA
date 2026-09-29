import express from 'express';
import prisma from '../lib/prisma.js';

const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const centers = await prisma.agriculturalCenter.findMany({
      orderBy: { name: 'asc' },
    });

    return res.json({ centers });
  } catch (error) {
    console.error('List centers error:', error);
    return res.status(500).json({ message: 'Erreur lors du chargement des centres' });
  }
});

export default router;

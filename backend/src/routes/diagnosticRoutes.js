import express from 'express';
import prisma from '../lib/prisma.js';
import { verifyToken } from '../lib/auth.js';

const router = express.Router();

router.use(verifyToken);

router.post('/', async (req, res) => {
  try {
    const { imageUrl, diseaseName, confidence, symptoms, recommendations, prevention } = req.body;

    if (!diseaseName) {
      return res.status(400).json({ message: 'Nom de maladie requis' });
    }

    const diagnostic = await prisma.diagnostic.create({
      data: {
        userId: req.user.id,
        imageUrl: imageUrl || null,
        diseaseName,
        confidence: Number(confidence || 0),
        symptoms: symptoms || null,
        recommendations: recommendations || null,
        prevention: prevention || null,
      },
    });

    return res.status(201).json({ diagnostic });
  } catch (error) {
    console.error('Create diagnostic error:', error);
    return res.status(500).json({ message: 'Erreur lors de la création du diagnostic' });
  }
});

router.get('/', async (req, res) => {
  try {
    const diagnostics = await prisma.diagnostic.findMany({
      where: { userId: req.user.id },
      orderBy: { createdAt: 'desc' },
    });

    return res.json({ diagnostics });
  } catch (error) {
    console.error('List diagnostics error:', error);
    return res.status(500).json({ message: 'Erreur lors du chargement des diagnostics' });
  }
});

export default router;

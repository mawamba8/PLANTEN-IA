from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from PIL import Image
import io
import numpy as np

app = FastAPI(title='PlantCare AI Service')

app.add_middleware(
    CORSMiddleware,
    allow_origins=['*'],
    allow_credentials=True,
    allow_methods=['*'],
    allow_headers=['*'],
)

@app.get('/api/health')
def health():
    return {
        'ok': True,
        'message': 'AI diagnosis service is running'
    }

@app.post('/api/diagnose')
async def diagnose(file: UploadFile = File(...)):
    content = await file.read()

    try:
        image = Image.open(io.BytesIO(content)).convert('RGB')
        image_array = np.array(image)
        height, width, _ = image_array.shape

        if height == 0 or width == 0:
            return {
                'error': 'Image invalide',
                'message': 'Impossible de traiter cette image de plante.'
            }

        return {
            'diseaseName': 'Mildiou',
            'confidence': 0.94,
            'symptoms': [
                'Taches circulaires sur les feuilles',
                'Feuilles qui jaunissent progressivement',
                'Zones foliaires déformées'
            ],
            'recommendations': [
                'Retirez les feuilles infectées immédiatement',
                'Évitez l’arrosage le soir',
                'Appliquez un traitement fongicide adapté'
            ],
            'prevention': [
                'Améliorez la ventilation autour des plantes',
                'Évitez l’humidité excessive',
                'Surveillez régulièrement les feuilles'
            ]
        }
    except Exception:
        return {
            'error': 'Image invalide',
            'message': 'Le fichier n’est pas une image exploitable.'
        }

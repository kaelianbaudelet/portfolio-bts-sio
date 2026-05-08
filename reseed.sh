#!/bin/bash
# Script pour re-seeder la base de données depuis dump.sql

DUMP_FILE="dump.sql"

# Vérifier si le fichier de dump existe
if [ ! -f "$DUMP_FILE" ]; then
    echo "Erreur : $DUMP_FILE n'existe pas !"
    exit 1
fi

echo "Restauration de la base de données depuis $DUMP_FILE..."

# On utilise docker-compose exec pour cibler le service 'database'
# L'option -T est nécessaire pour rediriger l'entrée standard (le fichier sql)
docker-compose exec -T database psql -U portfolio portfolio < "$DUMP_FILE"

if [ $? -eq 0 ]; then
    echo "La base de données a été ré-seedée avec succès !"
else
    echo "Une erreur est survenue lors de la restauration."
    exit 1
fi

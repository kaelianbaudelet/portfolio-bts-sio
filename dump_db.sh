#!/bin/bash
# Script pour dumper la base de données actuelle vers dump.sql

DUMP_FILE="dump.sql"

echo "Création du dump de la base de données dans $DUMP_FILE..."

# On utilise docker-compose exec pour générer le dump
# --clean et --if-exists permettent de faciliter le re-seed ultérieur
docker-compose exec -T database pg_dump -U portfolio --clean --if-exists portfolio > "$DUMP_FILE"

if [ $? -eq 0 ]; then
    echo "Dump créé avec succès dans $DUMP_FILE !"
else
    echo "Une erreur est survenue lors de la création du dump."
    exit 1
fi

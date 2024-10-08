# Étape 1 : Construire l'application React
FROM node:14 AS build

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers de l'application
COPY . .

# Construire l'application React
RUN npm run build

# Vérifier que le répertoire build existe
RUN ls -la /app/dist

# Étape 2 : Servir l'application construite avec Nginx
FROM nginx:alpine

# Copier les fichiers de build de l'étape précédente
COPY --from=build /app/dist /usr/share/nginx/html

# Exposer le port 80
EXPOSE 5173

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]

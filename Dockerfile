# Use NodeJS base image
FROM node:13 as build

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy app source
COPY . .

# Compile typescript
RUN npm install -g @ionic/cli
RUN ionic build

FROM nginx:alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /usr/src/app/www/ /usr/share/nginx/html/

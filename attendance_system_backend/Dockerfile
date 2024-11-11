# Step 1: Use an official Node.js image
FROM node:18

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json (for dependencies)
COPY package*.json ./

# Step 4: Install the dependencies
RUN npm install

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Expose port 3000 for the application
EXPOSE 3000

# Step 7: Command to start the Node.js app (runs the app)
CMD ["npm", "start"]

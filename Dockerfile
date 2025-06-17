# 1. Use official Node.js image as the base
FROM node:18-alpine AS deps

# 2. Set working directory
WORKDIR /app

# 3. Install dependencies
COPY package.json package-lock.json* ./  
RUN npm install

# 4. Copy application source code
COPY . .

# 5. Build the Next.js application
RUN npm run build

# 6. Use a minimal Node.js image to run the app
FROM node:18-alpine AS runner

WORKDIR /app

# 7. Copy build output and node_modules from previous stage
COPY --from=deps /app/node_modules ./node_modules
COPY --from=deps /app/.next ./.next
COPY --from=deps /app/public ./public
COPY --from=deps /app/package.json ./package.json

# 8. Set environment variable (can be overridden)
ENV NODE_ENV production
ENV PORT 3000

# 9. Expose port
EXPOSE 3000

# 10. Start the Next.js app
CMD ["npm", "start"]

import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  server: {
    host: true,            // bind to 0.0.0.0 for LAN access
    port: 5373,
    strictPort: true,
    open: true,
    proxy: {
      '/api':    { target: 'http://localhost:4100', changeOrigin: true },
      '/photos': { target: 'http://localhost:4100', changeOrigin: true },
    },
  },
  preview: { host: true, port: 4373, strictPort: true },
});

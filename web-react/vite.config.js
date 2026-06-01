import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
  plugins: [react()],
  // Pinned to 5273 (uncommon) with strictPort so it fails loudly if the port
  // is taken, instead of silently auto-bumping to 5174 like Vite's default.
  // host: true binds to 0.0.0.0 so other devices on the same Wi-Fi can hit it.
  server: { host: true, port: 5273, strictPort: true, open: true },
  preview: { host: true, port: 4273, strictPort: true },
});

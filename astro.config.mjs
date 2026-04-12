import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
  output: 'server',
  adapter: cloudflare({
    platformProxy: { enabled: true },
    imageService: 'compile',
    sessionKVBindingName: undefined,
  }),
  image: { service: { entrypoint: 'astro/assets/services/noop' } },
  vite: {
    plugins: [tailwindcss()],
  },
});

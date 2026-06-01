// One-off extractor: pull the React/JSX sources out of the design bundle so we
// can read them and plan a Flutter port. Reads the bundled HTML, parses the
// __bundler/manifest JSON, base64-decodes each entry, gunzips if needed, and
// writes the text/babel + text/javascript assets to ./_extracted/.
import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'node:fs';
import { gunzipSync } from 'node:zlib';
import { join } from 'node:path';

const HTML = 'GnK Restaurants App _Standalone_ (1) (1).html';
const OUT = '_extracted';

const html = readFileSync(HTML, 'utf8');

function sliceScript(type) {
  const re = new RegExp(`<script type="__bundler/${type}">([\\s\\S]*?)<\\/script>`);
  const m = html.match(re);
  if (!m) throw new Error(`No ${type} script tag`);
  return JSON.parse(m[1]);
}

const manifest = sliceScript('manifest');
const template = sliceScript('template');

if (!existsSync(OUT)) mkdirSync(OUT);

// Map UUID -> filename by parsing the template for src/href references.
const nameByUuid = {};
for (const uuid of Object.keys(manifest)) {
  // Find an inline reference of this UUID in the template; surrounding chars
  // sometimes hint at the original asset filename. Fall back to mime-based name.
  const idx = template.indexOf(uuid);
  let hint = '';
  if (idx >= 0) {
    const ctx = template.slice(Math.max(0, idx - 80), idx + uuid.length + 80);
    hint = ctx;
  }
  const mime = manifest[uuid].mime || 'application/octet-stream';
  let ext = '.bin';
  if (mime.includes('javascript') || mime.includes('jsx') || mime.includes('babel')) ext = '.jsx';
  else if (mime.includes('css')) ext = '.css';
  else if (mime.includes('json')) ext = '.json';
  else if (mime.includes('html')) ext = '.html';
  else if (mime.includes('font')) ext = '.woff2';
  else if (mime.includes('png')) ext = '.png';
  else if (mime.includes('jpeg') || mime.includes('jpg')) ext = '.jpg';
  else if (mime.includes('svg')) ext = '.svg';
  else if (mime.includes('webp')) ext = '.webp';
  nameByUuid[uuid] = { ext, hint };
}

const summary = [];
for (const [uuid, entry] of Object.entries(manifest)) {
  let bytes = Buffer.from(entry.data, 'base64');
  if (entry.compressed) {
    try { bytes = gunzipSync(bytes); } catch (e) { /* leave as-is */ }
  }
  const { ext } = nameByUuid[uuid];
  const fname = join(OUT, `${uuid}${ext}`);
  writeFileSync(fname, bytes);
  summary.push({ uuid, ext, mime: entry.mime, bytes: bytes.length, compressed: !!entry.compressed });
}

// Also write the template so we can read it as a normal file.
writeFileSync(join(OUT, '_template.html'), template);

// Sort by size descending — biggest assets are usually the interesting React files.
summary.sort((a, b) => b.bytes - a.bytes);
console.log('Wrote', summary.length, 'assets to', OUT);
console.log('Top 15 by size:');
for (const s of summary.slice(0, 15)) {
  console.log(`  ${s.uuid}${s.ext.padEnd(6)} ${String(s.bytes).padStart(8)} bytes  ${s.mime}`);
}

// Map the 6 restaurant photo UUIDs to their names by parsing ext_resources.
// ext_resources is a JSON array of { id, uuid, ... } objects; the `id` is the
// runtime resource key (e.g. "stanley"), the `uuid` references the manifest blob.
import { readFileSync, copyFileSync, mkdirSync, existsSync } from 'node:fs';
import { join } from 'node:path';

const HTML = 'GnK Restaurants App _Standalone_ (1) (1).html';
const html = readFileSync(HTML, 'utf8');

const m = html.match(/<script type="__bundler\/ext_resources">([\s\S]*?)<\/script>/);
if (!m) { console.error('No ext_resources script'); process.exit(1); }
const extResources = JSON.parse(m[1]);

// Names referenced in primitives.jsx
const KEYS = ['stanley', 'sax', 'byganz', 'kikis', 'buoy', 'mazeej'];

if (!existsSync('assets')) mkdirSync('assets');
if (!existsSync('assets/photos')) mkdirSync('assets/photos');

console.log('ext_resources entries:', extResources.length);
const mapping = {};
for (const e of extResources) {
  if (KEYS.includes(e.id)) mapping[e.id] = e.uuid;
}
console.log('Restaurant mapping:');
for (const k of KEYS) {
  const uuid = mapping[k];
  if (!uuid) { console.log(`  ${k}: NOT FOUND`); continue; }
  const src = join('_extracted', `${uuid}.jpg`);
  const dst = join('assets', 'photos', `${k}.jpg`);
  copyFileSync(src, dst);
  console.log(`  ${k}: ${uuid} -> ${dst}`);
}

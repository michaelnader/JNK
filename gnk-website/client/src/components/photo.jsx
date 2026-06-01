// Monochrome photo treatment — grayscale + Deep Denim tint.
// Used by hero banners, restaurant cards, and avatars.
import React from 'react';

export function MonoPhoto({ src, alt = '', fit = 'cover', style }) {
  return (
    <div style={{
      position: 'relative',
      width: '100%', height: '100%',
      overflow: 'hidden',
      ...style,
    }}>
      <img
        src={src} alt={alt}
        style={{
          width: '100%', height: '100%', objectFit: fit,
          filter: 'var(--mono-filter)',
          display: 'block',
        }}
      />
      <div style={{
        position: 'absolute', inset: 0,
        background: 'var(--mono-tint)',
        mixBlendMode: 'color',
        pointerEvents: 'none',
      }}/>
    </div>
  );
}

export function Hero({ photo, height = '70vh', children }) {
  return (
    <section style={{
      position: 'relative',
      width: '100%',
      height,
      minHeight: 540,
      overflow: 'hidden',
      color: '#fff',
    }}>
      <MonoPhoto src={photo} alt=""/>
      {/* darkening wash for legibility */}
      <div style={{
        position: 'absolute', inset: 0,
        background: 'linear-gradient(180deg, rgba(0,0,0,0.20) 0%, rgba(0,0,0,0.55) 100%)',
        pointerEvents: 'none',
      }}/>
      {/* content slot */}
      <div style={{
        position: 'absolute', inset: 0,
        display: 'flex', alignItems: 'flex-end',
      }}>
        <div className="container" style={{ paddingBottom: 'clamp(40px, 8vh, 96px)', width: '100%' }}>
          {children}
        </div>
      </div>
    </section>
  );
}

export function Avatar({ src, size = 44, ring = false }) {
  return (
    <div style={{
      position: 'relative',
      width: size, height: size,
      borderRadius: '50%',
      overflow: 'hidden',
      border: ring ? '2px solid var(--bg-cream)' : 'none',
      boxShadow: '0 2px 6px rgba(0,0,0,0.18)',
      flexShrink: 0,
    }}>
      <MonoPhoto src={src}/>
    </div>
  );
}

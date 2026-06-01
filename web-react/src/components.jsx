// G'nK Off Duty primitives — ported from the bundle's primitives.jsx.
// Same design vocabulary as the Flutter widgets, just JSX.
import React from 'react';
import { T5, FONT5, MONO_FILTER, MONO_TINT } from './theme.js';

// ─── shell ────────────────────────────────────────────────────────────────
export function ScreenBg5({ children, photo, tone = 'grey' }) {
  const usePhoto = tone === 'photo' && photo;
  let bg;
  if (tone === 'dark') bg = '#2B2B2B';
  else bg = T5.scene;

  return (
    <div style={{
      width: '100%', height: '100%', background: bg,
      color: T5.textDark, fontFamily: FONT5,
      position: 'relative', overflow: 'hidden',
    }}>
      {usePhoto && (
        <>
          <div style={{
            position: 'absolute', inset: 0,
            background: `url(${photo}) center / cover no-repeat`,
            filter: MONO_FILTER,
          }}/>
          <div style={{
            position: 'absolute', inset: 0,
            background: MONO_TINT, mixBlendMode: 'color',
          }}/>
          <div style={{
            position: 'absolute', inset: 0,
            background: 'linear-gradient(180deg, rgba(26,29,41,0.10) 0%, rgba(26,29,41,0.65) 100%)',
          }}/>
        </>
      )}
      <div style={{
        position: 'absolute', inset: 0, pointerEvents: 'none',
        background: 'radial-gradient(ellipse at 50% 0%, rgba(255,255,255,0.05), transparent 60%), radial-gradient(ellipse at 50% 100%, rgba(0,0,0,0.22), transparent 55%)',
      }}/>
      <div style={{
        position: 'absolute', inset: 0, pointerEvents: 'none', opacity: 0.18,
        backgroundImage: 'radial-gradient(rgba(255,255,255,0.10) 1px, transparent 1px)',
        backgroundSize: '3px 3px', mixBlendMode: 'overlay',
      }}/>
      <div style={{ position: 'relative', zIndex: 1, width: '100%', height: '100%' }}>
        {children}
      </div>
    </div>
  );
}

// ─── cards ────────────────────────────────────────────────────────────────
export function CardDark5({ children, style, padding = 22 }) {
  return (
    <div style={{
      background: T5.cardDark, color: T5.textWhite,
      borderRadius: 30, padding,
      position: 'relative', overflow: 'hidden',
      boxShadow: '0 10px 30px rgba(0,0,0,0.18), inset 0 1px 0 rgba(255,255,255,0.06)',
      ...style,
    }}>{children}</div>
  );
}

export function CardLight5({ children, style, padding = 22 }) {
  return (
    <div style={{
      background: T5.cardLight, color: T5.textDark,
      borderRadius: 30, padding,
      position: 'relative', overflow: 'hidden',
      boxShadow: '0 10px 30px rgba(0,0,0,0.10), inset 0 1px 0 rgba(255,255,255,0.6), inset 0 -1px 0 rgba(0,0,0,0.05)',
      ...style,
    }}>
      <div style={{
        position: 'absolute', top: 0, left: 0, right: 0, height: '50%',
        background: 'linear-gradient(180deg, rgba(255,255,255,0.35), transparent)',
        borderRadius: '30px 30px 0 0', pointerEvents: 'none',
      }}/>
      <div style={{ position: 'relative' }}>{children}</div>
    </div>
  );
}

export function CardGold5({ children, style, padding = 22 }) {
  return (
    <div style={{
      background: `linear-gradient(160deg, ${T5.goldLight}, ${T5.gold} 60%, ${T5.goldDeep})`,
      color: T5.textDark,
      borderRadius: 30, padding,
      position: 'relative', overflow: 'hidden',
      boxShadow: '0 10px 30px rgba(47,62,74,0.30), inset 0 1px 0 rgba(255,255,255,0.30), inset 0 -1px 0 rgba(0,0,0,0.10)',
      ...style,
    }}>{children}</div>
  );
}

export function CardPhoto5({ photo, children, style, padding = 22 }) {
  return (
    <div style={{
      borderRadius: 30, padding: 0,
      position: 'relative', overflow: 'hidden',
      boxShadow: '0 14px 32px rgba(0,0,0,0.28), inset 0 1px 0 rgba(255,255,255,0.10)',
      ...style,
    }}>
      <div style={{
        position: 'absolute', inset: 0,
        background: `url(${photo}) center / cover no-repeat`,
        filter: MONO_FILTER,
      }}/>
      <div style={{
        position: 'absolute', inset: 0,
        background: MONO_TINT, mixBlendMode: 'color',
      }}/>
      <div style={{
        position: 'absolute', inset: 0,
        background: 'linear-gradient(180deg, rgba(0,0,0,0.05) 0%, rgba(0,0,0,0.55) 100%)',
      }}/>
      <div style={{ position: 'relative', padding, color: T5.textWhite }}>{children}</div>
    </div>
  );
}

// ─── top bar ──────────────────────────────────────────────────────────────
export function TopBar5({ left, right, title, dark = false, style }) {
  const fg = dark ? T5.textWhite : T5.textDark;
  return (
    <div style={{
      position: 'absolute', top: 62, left: 0, right: 0,
      padding: '0 20px',
      display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      zIndex: 9, ...style,
    }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>{left}</div>
      {title && <span style={{ fontSize: 15, fontWeight: 600, color: fg, letterSpacing: -0.2 }}>{title}</span>}
      <div style={{ display: 'flex', gap: 8 }}>{right}</div>
    </div>
  );
}

export function RoundBtn5({ children, size = 42, dark = false, style }) {
  return (
    <div style={{
      width: size, height: size, borderRadius: '50%',
      background: dark ? T5.cardDark : T5.cardLight,
      color: dark ? T5.textWhite : T5.textDark,
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      boxShadow: dark
        ? '0 4px 14px rgba(0,0,0,0.2), inset 0 1px 0 rgba(255,255,255,0.08)'
        : '0 4px 14px rgba(0,0,0,0.1), inset 0 1px 0 rgba(255,255,255,0.6)',
      ...style,
    }}>{children}</div>
  );
}

// ─── icons ────────────────────────────────────────────────────────────────
export function Ico({ kind, color, size = 16 }) {
  const c = color || 'currentColor';
  const s = { stroke: c, strokeWidth: 1.6, fill: 'none', strokeLinecap: 'round', strokeLinejoin: 'round' };
  switch (kind) {
    case 'back':   return <svg width={size} height={size} viewBox="0 0 16 16"><path d="M10 2L4 8L10 14" {...s}/></svg>;
    case 'close':  return <svg width={size} height={size} viewBox="0 0 16 16"><path d="M2 2L14 14M14 2L2 14" {...s}/></svg>;
    case 'search': return <svg width={size} height={size} viewBox="0 0 16 16"><circle cx="7" cy="7" r="5" {...s}/><path d="M14 14L11 11" {...s}/></svg>;
    case 'bell':   return <svg width={size} height={size} viewBox="0 0 16 16"><path d="M3 12L2 13.5h12L13 12V8a5 5 0 00-10 0v4z" {...s}/><path d="M6.5 15.5a1.5 1.5 0 003 0" {...s}/></svg>;
    case 'plus':   return <svg width={size} height={size} viewBox="0 0 16 16"><path d="M8 2v12M2 8h12" {...s}/></svg>;
    case 'heart':  return <svg width={size} height={size} viewBox="0 0 16 16"><path d="M8 13.5C7.5 13.5 1.5 9.5 1.5 5.5C1.5 3.5 3 2 4.5 2C6 2 7 2.8 8 4C9 2.8 10 2 11.5 2C13 2 14.5 3.5 14.5 5.5C14.5 9.5 8.5 13.5 8 13.5Z" {...s}/></svg>;
    case 'check':  return <svg width={size} height={size} viewBox="0 0 16 16"><path d="M3 8L7 12L13 4" {...s}/></svg>;
    case 'home':   return <svg width={size} height={size} viewBox="0 0 16 16"><path d="M2 7L8 2L14 7V13a1 1 0 01-1 1H3a1 1 0 01-1-1V7z" {...s}/></svg>;
    case 'cal':    return <svg width={size} height={size} viewBox="0 0 16 16"><rect x="2" y="3" width="12" height="11" rx="1.5" {...s}/><path d="M2 6h12M5 1v3M11 1v3" {...s}/></svg>;
    case 'grid':   return <svg width={size} height={size} viewBox="0 0 16 16"><rect x="2" y="2" width="5" height="5" rx="1" {...s}/><rect x="9" y="2" width="5" height="5" rx="1" {...s}/><rect x="2" y="9" width="5" height="5" rx="1" {...s}/><rect x="9" y="9" width="5" height="5" rx="1" {...s}/></svg>;
    case 'wifi':   return <svg width={size} height={size} viewBox="0 0 16 16"><path d="M2 6a8 8 0 0112 0M4 9a5 5 0 018 0M6 12a2 2 0 014 0" {...s}/></svg>;
    case 'key':    return <svg width={size} height={size} viewBox="0 0 16 16"><circle cx="5" cy="11" r="3" {...s}/><path d="M7 9L14 2M11 5l2 2" {...s}/></svg>;
    case 'arrow':  return <svg width={size} height={size} viewBox="0 0 16 16"><path d="M3 8h10M9 4l4 4-4 4" {...s}/></svg>;
    case 'me':     return <svg width={size} height={size} viewBox="0 0 16 16"><circle cx="8" cy="5" r="2.5" {...s}/><path d="M2 15c0-3.3 2.7-6 6-6s6 2.7 6 6" {...s}/></svg>;
    case 'star':   return <svg width={size} height={size} viewBox="0 0 16 16" fill={c}><path d="M8 1L9.9 5.5L15 5.9L11 9.2L12.2 14.2L8 11.7L3.8 14.2L5 9.2L1 5.9L6.1 5.5L8 1Z"/></svg>;
    default: return null;
  }
}

// ─── CTA pills ────────────────────────────────────────────────────────────
export function CTAStart({ children, dark = false, style }) {
  const bg = dark ? T5.cardDark : T5.cardLight;
  const fg = dark ? T5.textWhite : T5.textDark;
  const innerBg = dark ? T5.cardLight : T5.cardDark;
  const innerFg = dark ? T5.textDark : T5.textWhite;
  return (
    <div style={{
      display: 'inline-flex', alignItems: 'center',
      height: 52, padding: '4px 4px 4px 22px',
      borderRadius: 9999,
      background: bg, color: fg,
      fontSize: 15, fontWeight: 600, letterSpacing: -0.2,
      gap: 16, minWidth: 120,
      boxShadow: dark
        ? '0 8px 22px rgba(0,0,0,0.20), inset 0 1px 0 rgba(255,255,255,0.08)'
        : '0 8px 22px rgba(0,0,0,0.12), inset 0 1px 0 rgba(255,255,255,0.6)',
      ...style,
    }}>
      <span>{children}</span>
      <div style={{
        width: 44, height: 44, borderRadius: '50%',
        background: innerBg, color: innerFg,
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        fontSize: 14, letterSpacing: 2, fontWeight: 500,
      }}>›››</div>
    </div>
  );
}

export function CTAGold({ children, style }) {
  return (
    <div style={{
      display: 'inline-flex', alignItems: 'center',
      height: 52, padding: '4px 4px 4px 22px',
      borderRadius: 9999,
      background: `linear-gradient(160deg, ${T5.goldLight}, ${T5.gold})`,
      color: T5.textDark,
      fontSize: 15, fontWeight: 600, letterSpacing: -0.2,
      gap: 16, minWidth: 120,
      boxShadow: '0 8px 22px rgba(47,62,74,0.30), inset 0 1px 0 rgba(255,255,255,0.32)',
      ...style,
    }}>
      <span>{children}</span>
      <div style={{
        width: 44, height: 44, borderRadius: '50%',
        background: T5.cardDark, color: T5.textWhite,
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        fontSize: 14, letterSpacing: 2, fontWeight: 500,
      }}>›››</div>
    </div>
  );
}

// ─── chip ─────────────────────────────────────────────────────────────────
export function Chip5({ children, active, dark, gold }) {
  let bg, fg, border;
  if (active) {
    if (gold) { bg = T5.gold; fg = T5.textDark; border = T5.gold; }
    else if (dark) { bg = T5.cardLight; fg = T5.textDark; border = T5.cardLight; }
    else { bg = T5.cardDark; fg = T5.textWhite; border = T5.cardDark; }
  } else {
    bg = 'transparent';
    fg = dark ? T5.textMuteD : T5.textMuteL;
    border = dark ? T5.divD : T5.divL;
  }
  return (
    <span style={{
      display: 'inline-flex', alignItems: 'center', gap: 6,
      padding: '7px 14px', borderRadius: 9999,
      background: bg, color: fg, border: `1px solid ${border}`,
      fontSize: 12, fontWeight: 500, letterSpacing: -0.05,
      whiteSpace: 'nowrap',
    }}>{children}</span>
  );
}

// ─── headlines + labels ──────────────────────────────────────────────────
export function Headline5({ children, size = 36, dark = false, italic, style }) {
  return (
    <div style={{
      fontFamily: FONT5, fontWeight: 600,
      fontSize: size, lineHeight: 1.05,
      letterSpacing: -0.025 * size + 'px',
      color: dark ? T5.textWhite : T5.textDark,
      fontStyle: italic ? 'italic' : 'normal',
      ...style,
    }}>{children}</div>
  );
}

export function Lbl5({ children, color, size = 12, style }) {
  return (
    <span style={{
      fontSize: size, fontWeight: 500, letterSpacing: -0.05,
      color: color || T5.textMuteL,
      ...style,
    }}>{children}</span>
  );
}

export function StatLine5({ value, label, icon, dark, style }) {
  const fg = dark ? T5.textWhite : T5.textDark;
  const mute = dark ? T5.textMuteD : T5.textMuteL;
  return (
    <div style={style}>
      <div style={{ fontSize: 30, fontWeight: 600, color: fg, letterSpacing: -0.5, lineHeight: 1 }}>{value}</div>
      <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginTop: 4 }}>
        {icon && <span style={{ color: mute, display: 'flex' }}><Ico kind={icon} size={11} color={mute}/></span>}
        <span style={{ fontSize: 11, color: mute }}>{label}</span>
      </div>
    </div>
  );
}

// ─── avatar ───────────────────────────────────────────────────────────────
export function Avatar5({ photo, size = 40, ring, badge }) {
  return (
    <div style={{ position: 'relative', width: size, height: size }}>
      <div style={{
        width: size, height: size, borderRadius: '50%',
        background: `url(${photo}) center / cover`,
        border: ring ? `2px solid ${T5.cardLight}` : 'none',
        boxShadow: '0 2px 6px rgba(0,0,0,0.18)',
        filter: MONO_FILTER,
      }}/>
      <div style={{
        position: 'absolute', inset: 0,
        borderRadius: '50%',
        background: MONO_TINT, mixBlendMode: 'color',
        pointerEvents: 'none',
      }}/>
      {badge && (
        <div style={{
          position: 'absolute', bottom: -2, right: -2,
          width: 18, height: 18, borderRadius: '50%',
          background: T5.gold, color: T5.textDark,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          border: `2px solid ${T5.cardLight}`,
        }}>
          <Ico kind="check" size={10} color={T5.textDark}/>
        </div>
      )}
    </div>
  );
}

// ─── bottom tab bar ──────────────────────────────────────────────────────
export function TabBar5({ active = 'home', dark }) {
  const tabs = [
    { id: 'home', icon: 'home' },
    { id: 'res', icon: 'cal' },
    { id: 'feed', icon: 'grid' },
    { id: 'me', icon: 'me' },
  ];
  return (
    <div style={{
      position: 'absolute', bottom: 22, left: 20, right: 20,
      height: 58, borderRadius: 9999,
      background: dark ? T5.cardDark : T5.cardLight,
      display: 'flex', alignItems: 'center', justifyContent: 'space-around',
      padding: '0 14px',
      boxShadow: dark
        ? '0 10px 26px rgba(0,0,0,0.25), inset 0 1px 0 rgba(255,255,255,0.06)'
        : '0 10px 26px rgba(0,0,0,0.12), inset 0 1px 0 rgba(255,255,255,0.55)',
      zIndex: 20,
    }}>
      {tabs.map(t => {
        const isActive = t.id === active;
        const fg = dark ? T5.textWhite : T5.textDark;
        if (isActive) {
          return (
            <div key={t.id} style={{
              width: 42, height: 42, borderRadius: '50%',
              background: T5.gold, color: T5.textDark,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              boxShadow: 'inset 0 1px 0 rgba(255,255,255,0.45)',
            }}>
              <Ico kind={t.icon} color={T5.textDark} size={18}/>
            </div>
          );
        }
        return (
          <div key={t.id} style={{ width: 42, height: 42, display: 'flex', alignItems: 'center', justifyContent: 'center', color: fg, opacity: 0.65 }}>
            <Ico kind={t.icon} color={fg} size={18}/>
          </div>
        );
      })}
    </div>
  );
}

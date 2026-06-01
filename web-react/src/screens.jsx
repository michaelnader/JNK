// G'nK Restaurants — 11 screens in 4 sections.
// Ported verbatim from the bundle's screens.jsx, with named imports instead
// of window globals.
import React from 'react';
import { T5, FONT5, PHOTOS, RESTAURANTS } from './theme.js';
import {
  ScreenBg5, CardDark5, CardLight5, CardGold5, CardPhoto5,
  TopBar5, RoundBtn5, Ico, CTAStart, CTAGold, Chip5,
  Headline5, Lbl5, StatLine5, Avatar5, TabBar5,
} from './components.jsx';

// ─── 01 · HOME ────────────────────────────────────────────────────────────
export function Home() {
  const feat = RESTAURANTS[0];
  return (
    <ScreenBg5 photo={feat.photo} tone="photo">
      <TopBar5
        left={<div style={{
          fontFamily: FONT5, fontSize: 18, fontWeight: 700, letterSpacing: -0.4, color: T5.textWhite,
        }}>G'NK</div>}
        right={[<RoundBtn5 key="b" dark><Ico kind="bell" color={T5.textWhite}/></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 142, left: 24, right: 24 }}>
        <Lbl5 color="rgba(255,255,255,0.75)">Tonight at</Lbl5>
        <Headline5 size={56} dark italic style={{ marginTop: 6 }}>Stanley.</Headline5>
        <Lbl5 color="rgba(255,255,255,0.85)" style={{ marginTop: 8, display: 'block' }}>Mediterranean · Sheikh Zayed</Lbl5>
      </div>
      <CardLight5 style={{ position: 'absolute', bottom: 152, left: 20, right: 20 }} padding={20}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
          <div>
            <StatLine5 value="14" label="tables tonight" icon="cal"/>
            <div style={{ marginTop: 14 }}>
              <StatLine5 value="On" label="serving · 6–11 PM" icon="wifi"/>
            </div>
          </div>
          <CardDark5 padding={14} style={{ width: 110, borderRadius: 22 }}>
            <Lbl5 color={T5.textMuteD} size={10}>From</Lbl5>
            <div style={{ fontSize: 22, fontWeight: 700, color: T5.gold, letterSpacing: -0.4, marginTop: 4 }}>EGP 250</div>
            <Lbl5 color={T5.textMuteD} size={10} style={{ marginTop: 2, display: 'block' }}>/ guest</Lbl5>
          </CardDark5>
        </div>
        <div style={{ marginTop: 22, display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
          <div style={{
            width: 44, height: 44, borderRadius: '50%',
            background: T5.cardDark, color: T5.textWhite,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
          }}>
            <Ico kind="heart" color={T5.gold} size={16}/>
          </div>
          <CTAStart dark>Reserve</CTAStart>
        </div>
      </CardLight5>
      <TabBar5 active="home"/>
    </ScreenBg5>
  );
}

// ─── 02 · RESTAURANTS LIST ────────────────────────────────────────────────
export function Restaurants() {
  return (
    <ScreenBg5>
      <TopBar5
        left={<RoundBtn5><Ico kind="back" color={T5.textDark}/></RoundBtn5>}
        right={[<RoundBtn5 key="s"><Ico kind="search" color={T5.textDark}/></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 118, left: 24, right: 24 }}>
        <Headline5 size={42}>Restaurants</Headline5>
        <div style={{ marginTop: 14, display: 'flex', gap: 6, flexWrap: 'wrap' }}>
          <Chip5 active>All · 6</Chip5>
          <Chip5>Cairo</Chip5>
          <Chip5>Sahel</Chip5>
          <Chip5>Red Sea</Chip5>
        </div>
      </div>
      <div style={{ position: 'absolute', top: 250, left: 20, right: 20, display: 'flex', flexDirection: 'column', gap: 12 }}>
        {RESTAURANTS.slice(0, 5).map((r, i) => (
          <RestRow5 key={r.id} r={r} variant={i === 0 ? 'photo' : (i % 2 === 1 ? 'dark' : 'light')}/>
        ))}
      </div>
      <TabBar5 active="home"/>
    </ScreenBg5>
  );
}

function RestRow5({ r, variant }) {
  const isDark = variant === 'dark';
  const isPhoto = variant === 'photo';
  const Card = isPhoto ? CardPhoto5 : (isDark ? CardDark5 : CardLight5);
  const fg = isDark || isPhoto ? T5.textWhite : T5.textDark;
  const mute = isDark || isPhoto ? T5.textMuteD : T5.textMuteL;
  return (
    <Card photo={r.photo} padding={14}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 14, position: 'relative' }}>
        {!isPhoto && <Avatar5 photo={r.photo} size={52} ring/>}
        {isPhoto && <div style={{ width: 4 }}/>}
        <div style={{ flex: 1, minWidth: 0 }}>
          <div style={{ fontSize: 18, fontWeight: 600, color: fg, letterSpacing: -0.2 }}>{r.name}</div>
          <Lbl5 color={mute}>{r.tag}</Lbl5>
        </div>
        <div style={{
          width: 36, height: 36, borderRadius: '50%',
          background: isDark || isPhoto ? T5.gold : T5.cardDark,
          color: isDark || isPhoto ? T5.textDark : T5.textWhite,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
        }}>
          <Ico kind="arrow" color={isDark || isPhoto ? T5.textDark : T5.textWhite} size={14}/>
        </div>
      </div>
    </Card>
  );
}

// ─── 03 · RESTAURANT DETAIL ───────────────────────────────────────────────
export function RestaurantDetail() {
  const r = RESTAURANTS[0];
  return (
    <ScreenBg5 photo={r.photo} tone="photo">
      <TopBar5
        left={<RoundBtn5 dark><Ico kind="back" color={T5.textWhite}/></RoundBtn5>}
        right={[<RoundBtn5 key="h" dark><Ico kind="heart" color={T5.gold}/></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 130, left: 24, right: 24 }}>
        <Lbl5 color="rgba(255,255,255,0.7)">Mediterranean · Cairo</Lbl5>
        <Headline5 size={56} dark style={{ marginTop: 6 }}>{r.name}.</Headline5>
      </div>
      <CardLight5 style={{ position: 'absolute', bottom: 24, left: 20, right: 20 }} padding={22}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
          <div>
            <StatLine5 value="98%" label="booked tonight" icon="cal"/>
            <div style={{ marginTop: 18 }}>
              <StatLine5 value="On" label="open · 6–11 PM" icon="wifi"/>
            </div>
          </div>
          <CardPhoto5 photo={r.photo} padding={0} style={{ width: 110, height: 130, borderRadius: 20 }}>
            <div style={{ height: '100%', display: 'flex', flexDirection: 'column', justifyContent: 'space-between', padding: 12 }}>
              <Lbl5 color="rgba(255,255,255,0.85)" size={10} style={{ textTransform: 'uppercase', letterSpacing: 1.2, fontWeight: 700 }}>STANLEY</Lbl5>
              <div style={{ display: 'flex', alignItems: 'center', gap: 4 }}>
                <Ico kind="star" color={T5.gold} size={11}/>
                <span style={{ fontSize: 11, fontWeight: 600, color: T5.textWhite }}>4.8</span>
              </div>
            </div>
          </CardPhoto5>
        </div>
        <div style={{ marginTop: 22, display: 'flex', gap: 10, alignItems: 'center' }}>
          <CardDark5 padding={14} style={{ borderRadius: 22, flex: 1 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
              <div style={{ width: 36, height: 36, borderRadius: '50%', background: T5.gold, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Ico kind="key" color={T5.textDark} size={14}/>
              </div>
              <div>
                <Lbl5 color={T5.textMuteD} size={10}>From</Lbl5>
                <div style={{ fontSize: 14, fontWeight: 600, color: T5.textWhite }}>EGP 250</div>
              </div>
            </div>
          </CardDark5>
          <CardDark5 padding={14} style={{ borderRadius: 22, flex: 1 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
              <div style={{ width: 36, height: 36, borderRadius: '50%', background: 'rgba(255,255,255,0.1)', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                <Ico kind="cal" color={T5.textWhite} size={14}/>
              </div>
              <div>
                <Lbl5 color={T5.textMuteD} size={10}>Today</Lbl5>
                <div style={{ fontSize: 14, fontWeight: 600, color: T5.textWhite }}>14 left</div>
              </div>
            </div>
          </CardDark5>
        </div>
        <div style={{ marginTop: 14, display: 'flex', justifyContent: 'flex-end' }}>
          <CTAStart dark>Reserve a table</CTAStart>
        </div>
      </CardLight5>
    </ScreenBg5>
  );
}

// ─── 04 · DATE PICKER ─────────────────────────────────────────────────────
export function DatePicker() {
  return (
    <ScreenBg5 tone="dark">
      <TopBar5
        left={<RoundBtn5 dark><Ico kind="back" color={T5.textWhite}/></RoundBtn5>}
        title={<span style={{ color: T5.textWhite }}>Step 1 of 4</span>}
        right={[<RoundBtn5 key="x" dark><Ico kind="close" color={T5.textWhite}/></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 118, left: 24, right: 24 }}>
        <Lbl5 color="rgba(255,255,255,0.65)">Stanley · 4 guests</Lbl5>
        <Headline5 size={42} dark style={{ marginTop: 6 }}>Choose<br/>a date.</Headline5>
      </div>
      <CardLight5 style={{ position: 'absolute', top: 280, left: 20, right: 20 }} padding={18}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <div>
            <Lbl5>Party size</Lbl5>
            <div style={{ fontSize: 22, fontWeight: 700, marginTop: 2, letterSpacing: -0.4 }}>4 guests</div>
          </div>
          <div style={{ display: 'flex', gap: 8 }}>
            <RoundBtn5 size={36}>−</RoundBtn5>
            <RoundBtn5 size={36}>+</RoundBtn5>
          </div>
        </div>
      </CardLight5>
      <CardLight5 style={{ position: 'absolute', top: 388, left: 20, right: 20 }} padding={18}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 14 }}>
          <div style={{ fontSize: 16, fontWeight: 700 }}>November 2025</div>
          <div style={{ display: 'flex', gap: 6 }}>
            <RoundBtn5 size={30}>‹</RoundBtn5>
            <RoundBtn5 size={30}>›</RoundBtn5>
          </div>
        </div>
        <Calendar5/>
      </CardLight5>
      <div style={{ position: 'absolute', bottom: 28, left: 20, right: 20, display: 'flex', justifyContent: 'flex-end' }}>
        <CTAGold>Fri 14 Nov</CTAGold>
      </div>
    </ScreenBg5>
  );
}

function Calendar5() {
  const days = ['M','T','W','T','F','S','S'];
  const offset = 5;
  const cells = [];
  for (let i = 0; i < offset; i++) cells.push(null);
  for (let d = 1; d <= 30; d++) cells.push(d);
  while (cells.length < 35) cells.push(null);
  const today = 12, selected = 14;
  return (
    <div>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(7, 1fr)', gap: 3, marginBottom: 6 }}>
        {days.map((d, i) => (
          <div key={i} style={{ textAlign: 'center', color: T5.textMuteL, fontSize: 11, fontWeight: 600 }}>{d}</div>
        ))}
      </div>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(7, 1fr)', gap: 3 }}>
        {cells.map((d, i) => {
          const isSel = d === selected;
          const isTod = d === today;
          const isPast = d && d < today;
          return (
            <div key={i} style={{
              aspectRatio: '1 / 1', display: 'flex', alignItems: 'center', justifyContent: 'center',
              borderRadius: '50%',
              background: isSel ? T5.gold : (isTod ? 'rgba(22,22,20,0.07)' : 'transparent'),
              color: isSel ? T5.textDark : (isPast ? T5.textFaintL : T5.textDark),
              fontSize: 13, fontWeight: isSel ? 700 : 500,
              opacity: isPast ? 0.4 : 1,
            }}>{d || ''}</div>
          );
        })}
      </div>
    </div>
  );
}

// ─── 05 · TIME SLOTS ──────────────────────────────────────────────────────
export function TimeSlots() {
  const slots = [['18:00','18:30','19:00'],['19:30','20:00','20:30'],['21:00','21:30','22:00'],['22:30','23:00','23:30']];
  return (
    <ScreenBg5 tone="dark">
      <TopBar5
        left={<RoundBtn5 dark><Ico kind="back" color={T5.textWhite}/></RoundBtn5>}
        title={<span style={{ color: T5.textWhite }}>Step 2 of 4</span>}
        right={[<RoundBtn5 key="x" dark><Ico kind="close" color={T5.textWhite}/></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 118, left: 24, right: 24 }}>
        <Lbl5 color="rgba(255,255,255,0.65)">Fri 14 Nov · Stanley · 4 guests</Lbl5>
        <Headline5 size={42} dark style={{ marginTop: 6 }}>Pick<br/>a time.</Headline5>
      </div>
      <CardLight5 style={{ position: 'absolute', top: 290, left: 20, right: 20 }} padding={18}>
        <Lbl5>Available tonight</Lbl5>
        <div style={{ marginTop: 12, display: 'flex', flexDirection: 'column', gap: 8 }}>
          {slots.map((row, ri) => (
            <div key={ri} style={{ display: 'flex', gap: 8 }}>
              {row.map(t => {
                const isPick = t === '20:30';
                return (
                  <div key={t} style={{
                    flex: 1, height: 50, borderRadius: 14,
                    background: isPick ? T5.gold : T5.cardLight2,
                    color: T5.textDark,
                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                    fontSize: 15, fontWeight: isPick ? 700 : 500, letterSpacing: -0.2,
                    boxShadow: 'inset 0 1px 0 rgba(255,255,255,0.4)',
                  }}>{t}</div>
                );
              })}
            </div>
          ))}
        </div>
      </CardLight5>
      <CardDark5 style={{ position: 'absolute', top: 562, left: 20, right: 20 }} padding={14}>
        <Lbl5 color={T5.textMuteD} size={12}>Tables are held <span style={{ color: T5.gold, fontWeight: 600 }}>15 minutes</span> past your booking time.</Lbl5>
      </CardDark5>
      <div style={{ position: 'absolute', bottom: 28, left: 20, right: 20, display: 'flex', justifyContent: 'flex-end' }}>
        <CTAGold>Continue · 20:30</CTAGold>
      </div>
    </ScreenBg5>
  );
}

// ─── 06 · OCCASION ────────────────────────────────────────────────────────
export function Occasion() {
  const opts = ['Birthday','Anniversary','Date night','Business','Celebration','Just because'];
  return (
    <ScreenBg5 tone="dark">
      <TopBar5
        left={<RoundBtn5 dark><Ico kind="back" color={T5.textWhite}/></RoundBtn5>}
        title={<span style={{ color: T5.textWhite }}>Step 3 of 4</span>}
        right={[<RoundBtn5 key="x" dark><Ico kind="close" color={T5.textWhite}/></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 118, left: 24, right: 24 }}>
        <Lbl5 color="rgba(255,255,255,0.65)">Optional · helps us prepare</Lbl5>
        <Headline5 size={42} dark style={{ marginTop: 6 }}>A bit<br/>more.</Headline5>
      </div>
      <CardLight5 style={{ position: 'absolute', top: 290, left: 20, right: 20 }} padding={18}>
        <Lbl5>Occasion</Lbl5>
        <div style={{ marginTop: 12, display: 'flex', flexWrap: 'wrap', gap: 6 }}>
          {opts.map((o, i) => <Chip5 key={o} active={i === 1} gold={i === 1}>{o}</Chip5>)}
        </div>
      </CardLight5>
      <CardLight5 style={{ position: 'absolute', top: 442, left: 20, right: 20 }} padding={18}>
        <Lbl5>Special request</Lbl5>
        <div style={{ marginTop: 10, fontSize: 14, lineHeight: 1.5, minHeight: 60, color: T5.textDark }}>
          Celebrating ten years.{' '}
          <span style={{ color: T5.textMuteL }}>A quiet corner table would be perfect, and a cake at the end if it's possible.</span>
          <span style={{ display: 'inline-block', width: 1.5, height: 14, background: T5.gold, marginLeft: 2, verticalAlign: 'middle' }}/>
        </div>
      </CardLight5>
      <CardDark5 style={{ position: 'absolute', top: 608, left: 20, right: 20 }} padding={14}>
        <Lbl5 color={T5.textMuteD} size={11}>Dietary</Lbl5>
        <div style={{ marginTop: 10, display: 'flex', gap: 6 }}>
          <Chip5 dark>Vegetarian</Chip5>
          <Chip5 dark active gold>Pescatarian</Chip5>
          <Chip5 dark>Gluten-free</Chip5>
        </div>
      </CardDark5>
      <div style={{ position: 'absolute', bottom: 28, left: 20, right: 20, display: 'flex', justifyContent: 'flex-end' }}>
        <CTAGold>Continue to review</CTAGold>
      </div>
    </ScreenBg5>
  );
}

// ─── 07 · REVIEW ──────────────────────────────────────────────────────────
export function Review() {
  const r = RESTAURANTS[0];
  return (
    <ScreenBg5 tone="dark">
      <TopBar5
        left={<RoundBtn5 dark><Ico kind="back" color={T5.textWhite}/></RoundBtn5>}
        title={<span style={{ color: T5.textWhite }}>Step 4 of 4</span>}
        right={[<RoundBtn5 key="x" dark><Ico kind="close" color={T5.textWhite}/></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 118, left: 24, right: 24 }}>
        <Headline5 size={42} dark>Your<br/>booking.</Headline5>
      </div>
      <CardPhoto5 photo={r.photo} style={{ position: 'absolute', top: 270, left: 20, right: 20, height: 170 }} padding={18}>
        <div style={{ display: 'flex', flexDirection: 'column', justifyContent: 'space-between', height: '100%' }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
            <div>
              <Lbl5 color="rgba(255,255,255,0.8)" size={11}>RESTAURANT</Lbl5>
              <Headline5 size={28} dark>{r.name}</Headline5>
            </div>
            <div style={{
              padding: '5px 10px', borderRadius: 9999, background: T5.gold, color: T5.textDark,
              fontSize: 10, fontWeight: 700, letterSpacing: 0.8, textTransform: 'uppercase',
            }}>Confirmed</div>
          </div>
          <Lbl5 color="rgba(255,255,255,0.8)" size={11}>FRI 14 NOV · 20:30 · 4 GUESTS</Lbl5>
        </div>
      </CardPhoto5>
      <CardLight5 style={{ position: 'absolute', top: 462, left: 20, right: 20 }} padding={0}>
        <ReviewRow5 label="Occasion" value="Anniversary · Pescatarian"/>
        <Div5/>
        <ReviewRow5 label="Note" value="Quiet corner, cake at the end"/>
        <Div5/>
        <ReviewRow5 label="Cancellation" value="Free until 24h before"/>
      </CardLight5>
      <CardGold5 style={{ position: 'absolute', top: 618, left: 20, right: 20 }} padding={18}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <div>
            <Lbl5 color="rgba(22,22,20,0.65)" size={11}>Refundable deposit</Lbl5>
            <div style={{ fontSize: 24, fontWeight: 700, color: T5.textDark, letterSpacing: -0.5, marginTop: 4 }}>EGP 1,000</div>
          </div>
          <div style={{
            width: 44, height: 44, borderRadius: '50%',
            background: T5.cardDark, color: T5.textWhite,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
          }}><Ico kind="arrow" color={T5.textWhite} size={16}/></div>
        </div>
      </CardGold5>
      <div style={{ position: 'absolute', bottom: 28, left: 20, right: 20, display: 'flex', justifyContent: 'flex-end' }}>
        <CTAGold>Continue to payment</CTAGold>
      </div>
    </ScreenBg5>
  );
}

function ReviewRow5({ label, value }) {
  return (
    <div style={{ padding: '14px 18px', display: 'flex', justifyContent: 'space-between', gap: 14 }}>
      <Lbl5>{label}</Lbl5>
      <div style={{ flex: 1, textAlign: 'right', fontSize: 14, fontWeight: 600, color: T5.textDark, letterSpacing: -0.1 }}>{value}</div>
    </div>
  );
}
function Div5() { return <div style={{ height: 1, background: T5.divL, margin: '0 18px' }}/>; }

// ─── 08 · PAYMENT ─────────────────────────────────────────────────────────
export function Payment() {
  return (
    <ScreenBg5 tone="dark">
      <TopBar5
        left={<RoundBtn5 dark><Ico kind="back" color={T5.textWhite}/></RoundBtn5>}
        title={<span style={{ color: T5.textWhite }}>Payment</span>}
        right={[<RoundBtn5 key="x" dark><Ico kind="close" color={T5.textWhite}/></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 118, left: 24, right: 24 }}>
        <Lbl5 color="rgba(255,255,255,0.65)">EGP 1,000 · refundable deposit</Lbl5>
        <Headline5 size={42} dark style={{ marginTop: 6 }}>How will<br/>you pay?</Headline5>
      </div>
      <CardLight5 style={{ position: 'absolute', top: 290, left: 20, right: 20 }} padding={6}>
        <div style={{
          height: 56, borderRadius: 24,
          background: T5.cardDark, color: T5.textWhite,
          display: 'flex', alignItems: 'center', justifyContent: 'center', gap: 8,
          fontSize: 18, fontWeight: 500, letterSpacing: -0.2,
        }}>
          <svg width="18" height="22" viewBox="0 0 22 26" fill="#fff"><path d="M17.5 13.5c0-3.4 2.8-5 2.9-5.1-1.6-2.3-4-2.6-4.9-2.7-2.1-.2-4 1.2-5 1.2-1.1 0-2.6-1.2-4.3-1.2-2.2 0-4.3 1.3-5.4 3.3-2.3 4-.6 9.9 1.6 13.1 1.1 1.6 2.4 3.3 4.1 3.3 1.6-.1 2.3-1.1 4.3-1.1s2.5 1.1 4.3 1c1.8 0 2.9-1.6 4-3.2 1.3-1.8 1.8-3.6 1.8-3.7-.1 0-3.4-1.3-3.4-5.1zM14.3 4.1C15.2 3 15.8 1.5 15.7 0c-1.3.1-2.8.9-3.7 2-.8.9-1.5 2.4-1.3 3.9 1.4.1 2.8-.7 3.6-1.8z"/></svg>
          <span>Pay</span>
        </div>
      </CardLight5>
      <div style={{ position: 'absolute', top: 374, left: 20, right: 20, display: 'flex', alignItems: 'center', gap: 12 }}>
        <div style={{ flex: 1, height: 1, background: 'rgba(255,255,255,0.12)' }}/>
        <Lbl5 color="rgba(255,255,255,0.55)" size={11}>OR USE A CARD</Lbl5>
        <div style={{ flex: 1, height: 1, background: 'rgba(255,255,255,0.12)' }}/>
      </div>
      <CardLight5 style={{ position: 'absolute', top: 414, left: 20, right: 20 }} padding={0}>
        <PayRow5 brand="VISA" name="Personal" last="4421" selected/>
        <Div5/>
        <PayRow5 brand="MC" name="Business" last="0392"/>
        <Div5/>
        <div style={{ padding: '14px 18px', display: 'flex', alignItems: 'center', gap: 12 }}>
          <div style={{ width: 32, height: 32, borderRadius: '50%', background: T5.gold, color: T5.textDark, display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 600 }}>+</div>
          <span style={{ fontSize: 14, fontWeight: 600, color: T5.textDark }}>Add a new card</span>
        </div>
      </CardLight5>
      <div style={{ position: 'absolute', bottom: 28, left: 20, right: 20, display: 'flex', justifyContent: 'flex-end' }}>
        <CTAGold>Pay EGP 1,000</CTAGold>
      </div>
    </ScreenBg5>
  );
}

function PayRow5({ brand, name, last, selected }) {
  return (
    <div style={{ padding: '14px 18px', display: 'flex', alignItems: 'center', gap: 14 }}>
      <div style={{
        width: 40, height: 28, borderRadius: 5,
        background: brand === 'VISA' ? 'linear-gradient(135deg,#1a1f71,#2a3f9d)' : 'linear-gradient(135deg,#232323,#454545)',
        color: '#fff', display: 'flex', alignItems: 'center', justifyContent: 'center',
        fontSize: 10, fontWeight: 700, letterSpacing: 0.3,
      }}>{brand}</div>
      <div style={{ flex: 1 }}>
        <div style={{ fontSize: 14, fontWeight: 600, color: T5.textDark }}>{name}</div>
        <Lbl5>•••• {last}</Lbl5>
      </div>
      <div style={{
        width: 22, height: 22, borderRadius: '50%',
        border: `2px solid ${selected ? T5.gold : 'rgba(22,22,20,0.18)'}`,
        background: selected ? T5.gold : 'transparent',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
      }}>{selected && <div style={{ width: 8, height: 8, borderRadius: '50%', background: T5.textDark }}/>}</div>
    </div>
  );
}

// ─── 09 · ADD CARD ────────────────────────────────────────────────────────
export function AddCard() {
  return (
    <ScreenBg5 tone="dark">
      <TopBar5
        left={<RoundBtn5 dark><Ico kind="back" color={T5.textWhite}/></RoundBtn5>}
        title={<span style={{ color: T5.textWhite }}>Add a card</span>}
        right={[<RoundBtn5 key="x" dark><Ico kind="close" color={T5.textWhite}/></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 118, left: 24, right: 24 }}>
        <Headline5 size={36} dark>New card.</Headline5>
      </div>
      <CardDark5 style={{ position: 'absolute', top: 200, left: 20, right: 20, height: 170 }} padding={22}>
        <div style={{ position: 'absolute', top: -40, right: -40, width: 180, height: 180, borderRadius: '50%', background: `radial-gradient(circle, ${T5.gold} 0%, transparent 60%)`, opacity: 0.5 }}/>
        <div style={{ position: 'relative', display: 'flex', justifyContent: 'space-between' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
            <div style={{ width: 10, height: 10, borderRadius: '50%', background: T5.gold }}/>
            <span style={{ fontSize: 16, fontWeight: 700, color: T5.textWhite, letterSpacing: -0.2 }}>G'NK</span>
          </div>
          <Lbl5 color={T5.textMuteD} size={10}>DEBIT</Lbl5>
        </div>
        <div style={{ position: 'relative', marginTop: 28, fontSize: 20, color: T5.textWhite, letterSpacing: 2.5, fontFamily: 'ui-monospace, monospace' }}>4242 1234 ••••</div>
        <div style={{ position: 'relative', display: 'flex', justifyContent: 'space-between', marginTop: 14 }}>
          <div>
            <Lbl5 color={T5.textMuteD} size={9}>NAME</Lbl5>
            <div style={{ fontSize: 13, color: T5.textWhite, marginTop: 2, fontWeight: 600 }}>AHMED SALEH</div>
          </div>
          <div>
            <Lbl5 color={T5.textMuteD} size={9}>EXPIRES</Lbl5>
            <div style={{ fontSize: 13, color: T5.textWhite, marginTop: 2, fontWeight: 600 }}>09 / 28</div>
          </div>
        </div>
      </CardDark5>
      <CardLight5 style={{ position: 'absolute', top: 392, left: 20, right: 20 }} padding={0}>
        <Field5 label="Card number" value="4242 1234 ••••" focused/>
        <Div5/>
        <div style={{ display: 'flex' }}>
          <div style={{ flex: 1, borderRight: `1px solid ${T5.divL}` }}>
            <Field5 label="Expires" value="09 / 28"/>
          </div>
          <div style={{ flex: 1 }}>
            <Field5 label="CVV" value="•••"/>
          </div>
        </div>
        <Div5/>
        <Field5 label="Name on card" value="Ahmed Saleh"/>
      </CardLight5>
      <div style={{ position: 'absolute', bottom: 28, left: 20, right: 20, display: 'flex', justifyContent: 'flex-end' }}>
        <CTAGold>Save · Pay EGP 1,000</CTAGold>
      </div>
    </ScreenBg5>
  );
}

function Field5({ label, value, focused }) {
  return (
    <div style={{ padding: '12px 18px' }}>
      <Lbl5 size={10} style={{ textTransform: 'uppercase', letterSpacing: 1.2, fontWeight: 700 }}>{label}</Lbl5>
      <div style={{ fontSize: 15, color: T5.textDark, marginTop: 4, fontWeight: 600, letterSpacing: 0.3 }}>
        {value}
        {focused && <span style={{ display: 'inline-block', width: 1.5, height: 14, background: T5.gold, marginLeft: 3, verticalAlign: 'middle' }}/>}
      </div>
    </div>
  );
}

// ─── 10 · CONFIRMATION ────────────────────────────────────────────────────
export function Confirmation() {
  const r = RESTAURANTS[0];
  return (
    <ScreenBg5 photo={r.photo} tone="photo">
      <TopBar5
        left={<RoundBtn5 dark><Ico kind="back" color={T5.textWhite}/></RoundBtn5>}
        right={[<RoundBtn5 key="d" dark><svg width="14" height="14" viewBox="0 0 14 14" fill="none"><path d="M7 1v9m-3-3l3 3 3-3M2 13h10" stroke={T5.textWhite} strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round"/></svg></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 130, left: 24, right: 24, textAlign: 'center' }}>
        <div style={{
          width: 64, height: 64, borderRadius: '50%',
          background: T5.gold, color: T5.textDark,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          margin: '0 auto 22px',
          boxShadow: '0 14px 30px rgba(47,62,74,0.40), inset 0 1px 0 rgba(255,255,255,0.30)',
        }}>
          <svg width="28" height="28" viewBox="0 0 28 28" fill="none">
            <path d="M8 14.5L12.5 19.5L21 10.5" stroke={T5.textDark} strokeWidth="2.6" strokeLinecap="round" strokeLinejoin="round"/>
          </svg>
        </div>
        <Lbl5 color="rgba(255,255,255,0.75)">Confirmation sent to ahmed@email.com</Lbl5>
        <Headline5 size={50} dark style={{ marginTop: 12 }}>You're in.</Headline5>
      </div>
      <CardLight5 style={{ position: 'absolute', bottom: 24, left: 20, right: 20 }} padding={20}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
          <Avatar5 photo={r.photo} size={52} ring/>
          <div style={{ flex: 1 }}>
            <div style={{ fontSize: 18, fontWeight: 700, letterSpacing: -0.2 }}>{r.name}</div>
            <Lbl5>{r.tag}</Lbl5>
          </div>
          <div style={{
            padding: '5px 10px', borderRadius: 9999, background: T5.cardDark, color: T5.gold,
            fontSize: 10, fontWeight: 700, letterSpacing: 0.8,
          }}>GNK-A4F92K</div>
        </div>
        <div style={{ marginTop: 16, paddingTop: 14, borderTop: `1px solid ${T5.divL}`, display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 10 }}>
          <Mini5 label="Date" value="Fri 14 Nov"/>
          <Mini5 label="Time" value="20:30"/>
          <Mini5 label="Guests" value="04"/>
        </div>
        <div style={{ marginTop: 16, display: 'flex', alignItems: 'center', gap: 12 }}>
          <QR5/>
          <div style={{ flex: 1 }}>
            <div style={{ fontSize: 13, fontWeight: 700 }}>Show on arrival</div>
            <Lbl5 style={{ display: 'block', marginTop: 4, lineHeight: 1.4 }}>Or just give your name.</Lbl5>
          </div>
          <CTAStart dark>Wallet</CTAStart>
        </div>
      </CardLight5>
    </ScreenBg5>
  );
}

function Mini5({ label, value }) {
  return (
    <div>
      <Lbl5 size={10} style={{ textTransform: 'uppercase', letterSpacing: 1.2, fontWeight: 700 }}>{label}</Lbl5>
      <div style={{ fontSize: 16, fontWeight: 700, marginTop: 4, letterSpacing: -0.2 }}>{value}</div>
    </div>
  );
}

function QR5() {
  const cells = Array.from({ length: 49 }, (_, i) => {
    const x = i % 7, y = Math.floor(i / 7);
    const inCorner = (x < 2 && y < 2) || (x > 4 && y < 2) || (x < 2 && y > 4);
    return inCorner || (x * 31 + y * 17 + 5) % 7 < 3;
  });
  return (
    <div style={{ width: 56, height: 56, padding: 3, borderRadius: 8, background: T5.cardDark, display: 'grid', gridTemplateColumns: 'repeat(7,1fr)', gap: 1 }}>
      {cells.map((on, i) => <div key={i} style={{ background: on ? T5.gold : T5.cardDark }}/>)}
    </div>
  );
}

// ─── 11 · MY RESERVATIONS ─────────────────────────────────────────────────
export function MyReservations() {
  return (
    <ScreenBg5>
      <TopBar5
        left={<RoundBtn5><Ico kind="back" color={T5.textDark}/></RoundBtn5>}
        right={[<RoundBtn5 key="s"><Ico kind="search" color={T5.textDark}/></RoundBtn5>]}
      />
      <div style={{ position: 'absolute', top: 118, left: 24, right: 24 }}>
        <Lbl5>9 bookings across G'nK</Lbl5>
        <Headline5 size={42} style={{ marginTop: 6 }}>Reservations</Headline5>
        <div style={{ marginTop: 14, display: 'flex', gap: 6 }}>
          <Chip5 active gold>Upcoming · 2</Chip5>
          <Chip5>Past · 7</Chip5>
          <Chip5>Cancelled</Chip5>
        </div>
      </div>
      <CardPhoto5 photo={PHOTOS.stanley} style={{ position: 'absolute', top: 296, left: 20, right: 20, height: 170 }} padding={18}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
          <div>
            <Lbl5 color="rgba(255,255,255,0.85)" size={10} style={{ textTransform: 'uppercase', letterSpacing: 1.2, fontWeight: 700 }}>IN 2 DAYS</Lbl5>
            <Headline5 size={32} dark style={{ marginTop: 6 }}>Stanley</Headline5>
            <Lbl5 color="rgba(255,255,255,0.85)" style={{ marginTop: 4 }}>Fri 14 Nov · 20:30 · 4 guests</Lbl5>
          </div>
          <div style={{
            padding: '5px 10px', borderRadius: 9999, background: T5.gold, color: T5.textDark,
            fontSize: 10, fontWeight: 700, letterSpacing: 0.8,
          }}>CONFIRMED</div>
        </div>
        <div style={{ position: 'absolute', bottom: 18, right: 18 }}>
          <CTAStart>View</CTAStart>
        </div>
      </CardPhoto5>
      <CardLight5 style={{ position: 'absolute', top: 482, left: 20, right: 20 }} padding={14}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
          <Avatar5 photo={PHOTOS.kikis} size={52} ring/>
          <div style={{ flex: 1 }}>
            <div style={{ fontSize: 16, fontWeight: 700, letterSpacing: -0.2 }}>KIKI's Beach</div>
            <Lbl5>Sat 22 Nov · 14:00 · cabana for 6</Lbl5>
          </div>
          <div style={{
            padding: '5px 10px', borderRadius: 9999, background: T5.cardDark, color: T5.gold,
            fontSize: 10, fontWeight: 700, letterSpacing: 0.8,
          }}>CONFIRMED</div>
        </div>
      </CardLight5>
      <CardDark5 style={{ position: 'absolute', top: 586, left: 20, right: 20 }} padding={14}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
          <Avatar5 photo={PHOTOS.sax} size={44}/>
          <div style={{ flex: 1 }}>
            <div style={{ fontSize: 15, fontWeight: 600, color: T5.textWhite }}>Sax</div>
            <Lbl5 color={T5.textMuteD}>Thu 6 Nov · past</Lbl5>
          </div>
          <Lbl5 color={T5.textMuteD} size={10} style={{ textTransform: 'uppercase', letterSpacing: 1, fontWeight: 700 }}>VIEW</Lbl5>
        </div>
      </CardDark5>
      <TabBar5 active="res"/>
    </ScreenBg5>
  );
}

import React from 'react';
import { IOSDevice } from './ios.jsx';
import {
  Home, Restaurants, RestaurantDetail,
  DatePicker, TimeSlots, Occasion, Review,
  Payment, AddCard, Confirmation, MyReservations,
} from './screens.jsx';

const W = 402;
const H = 874;

function Phone({ children }) {
  return <IOSDevice width={W} height={H}>{children}</IOSDevice>;
}

function Artboard({ label, children }) {
  return (
    <figure style={{
      margin: 0,
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      gap: 10,
    }}>
      <Phone>{children}</Phone>
      <figcaption style={{
        fontSize: 12,
        fontWeight: 500,
        color: 'rgba(60,50,40,0.7)',
        letterSpacing: -0.1,
      }}>{label}</figcaption>
    </figure>
  );
}

function Section({ title, subtitle, children }) {
  return (
    <section style={{ marginBottom: 64 }}>
      <header style={{ marginBottom: 24, maxWidth: 1200 }}>
        <h2 style={{
          margin: 0, fontSize: 22, fontWeight: 600, letterSpacing: -0.3,
          color: 'rgba(40,30,20,0.85)',
        }}>{title}</h2>
        {subtitle && (
          <p style={{
            margin: '6px 0 0', fontSize: 14, fontWeight: 500,
            color: 'rgba(60,50,40,0.6)',
          }}>{subtitle}</p>
        )}
      </header>
      <div style={{
        display: 'flex', gap: 28, alignItems: 'flex-start',
        overflowX: 'auto', paddingBottom: 12,
      }}>
        {children}
      </div>
    </section>
  );
}

export default function App() {
  return (
    <main style={{ padding: '48px 32px 64px', maxWidth: 1600, margin: '0 auto' }}>
      <header style={{ marginBottom: 48 }}>
        <h1 style={{
          margin: 0, fontSize: 38, fontWeight: 700, letterSpacing: -0.8,
          color: 'rgba(40,30,20,0.85)',
        }}>G'nK Restaurants <span style={{ color: 'rgba(60,50,40,0.55)', fontWeight: 500 }}>· v8 · Off Duty</span></h1>
        <p style={{
          margin: '8px 0 0', fontSize: 14, color: 'rgba(60,50,40,0.6)', maxWidth: 720, lineHeight: 1.5,
        }}>
          Warm cream scenes with True Black, Charcoal and Washed Denim accents.
          First light-scene variant. 11 screens across four sections.
        </p>
      </header>

      <Section title="01 · Discovery" subtitle="How a guest enters the app, browses the group, and lands on a restaurant.">
        <Artboard label="Home — featured tonight"><Home/></Artboard>
        <Artboard label="All restaurants"><Restaurants/></Artboard>
        <Artboard label="Restaurant detail"><RestaurantDetail/></Artboard>
      </Section>

      <Section title="02 · Booking flow" subtitle="Four steps: date · time · occasion · review.">
        <Artboard label="1 · Date & party size"><DatePicker/></Artboard>
        <Artboard label="2 · Time slot"><TimeSlots/></Artboard>
        <Artboard label="3 · Occasion & request"><Occasion/></Artboard>
        <Artboard label="4 · Review"><Review/></Artboard>
      </Section>

      <Section title="03 · Payment & confirmation" subtitle="Apple Pay, saved cards, or add a new one.">
        <Artboard label="Payment method"><Payment/></Artboard>
        <Artboard label="Add a new card"><AddCard/></Artboard>
        <Artboard label="Confirmation"><Confirmation/></Artboard>
      </Section>

      <Section title="04 · My reservations" subtitle="Upcoming, past, and cancelled bookings — single source of truth across the group.">
        <Artboard label="My reservations"><MyReservations/></Artboard>
      </Section>

      <footer style={{
        marginTop: 48, paddingTop: 24, borderTop: '1px solid rgba(14,14,14,0.10)',
        fontSize: 12, color: 'rgba(60,50,40,0.55)', textAlign: 'center',
      }}>
        Off Duty palette · Plus Jakarta Sans · React + Vite
      </footer>
    </main>
  );
}

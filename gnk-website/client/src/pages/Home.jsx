import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { api } from '../lib/api.js';
import { Hero } from '../components/photo.jsx';
import { RestaurantCard } from '../components/restaurant-card.jsx';
import { CTAGold, CTAStart } from '../components/ui.jsx';
import { CardDark, CardLight } from '../components/cards.jsx';

export default function Home() {
  const [restaurants, setRestaurants] = useState([]);
  useEffect(() => { api.restaurants().then(setRestaurants).catch(() => {}); }, []);
  const featured = restaurants[0];

  return (
    <>
      {featured && (
        <Hero photo={featured.photo} height="78vh">
          <div style={{ maxWidth: 760 }}>
            <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.85)' }}>
              Tonight at
            </div>
            <h1 className="h1" style={{ color: '#fff', marginTop: 8, fontStyle: 'italic' }}>
              {featured.name}.
            </h1>
            <p style={{
              color: 'rgba(255,255,255,0.85)',
              fontSize: 18, lineHeight: 1.6, marginTop: 14, maxWidth: 560,
            }}>
              {featured.blurb} A modern Mediterranean table — open from {featured.hours} ·
              from EGP {featured.deposit} / guest deposit.
            </p>
            <div className="hero-cta-row">
              <Link to={`/restaurants/${featured.id}`} style={{ textDecoration: 'none' }}>
                <CTAGold>Reserve a table</CTAGold>
              </Link>
              <Link to="/restaurants" style={{ textDecoration: 'none' }}>
                <CTAStart>All six rooms</CTAStart>
              </Link>
            </div>
          </div>
        </Hero>
      )}

      {/* Six rooms intro */}
      <section className="container">
        <div className="intro-row">
          <div>
            <div className="lbl-eyebrow">The Group</div>
            <h2 className="h2" style={{ marginTop: 10 }}>Six rooms,<br/>one table.</h2>
          </div>
          <p style={{ color: 'var(--text-mute-l)', fontSize: 16, lineHeight: 1.7 }}>
            From a hearth-lit Mediterranean room in Sheikh Zayed to a 4&#x202F;AM
            cocktail supper in Zamalek, a 60-metre pool on the north coast
            and a hotel signature kitchen on the Red Sea — the G'nK group
            keeps one reservation system across all six. Book one,
            it appears across the entire account.
          </p>
        </div>
      </section>

      {/* Grid */}
      <section className="container" style={{ paddingTop: 32 }}>
        <div className="grid-cards">
          {restaurants.map(r => <RestaurantCard key={r.id} r={r}/>)}
        </div>
      </section>

      {/* Why book through G'nK */}
      <section className="container" style={{ paddingTop: 32 }}>
        <div className="grid-features">
          <CardLight padding={28}>
            <div className="lbl-eyebrow">One account</div>
            <h3 className="h3" style={{ marginTop: 10 }}>Every room, one history.</h3>
            <p style={{ color: 'var(--text-mute-l)', marginTop: 10, fontSize: 14 }}>
              Past visits, preferences, dietary notes — visible to the host on
              arrival, across every room.
            </p>
          </CardLight>
          <CardDark padding={28} style={{ color: '#fff' }}>
            <div className="lbl-eyebrow" style={{ color: 'rgba(255,255,255,0.55)' }}>Refundable deposits</div>
            <h3 className="h3" style={{ marginTop: 10, color: '#fff' }}>Held in trust, returned on arrival.</h3>
            <p style={{ color: 'rgba(255,255,255,0.7)', marginTop: 10, fontSize: 14 }}>
              The deposit secures your table. It's refunded to your card the
              moment you sit down — or kept whole if you cancel inside 24 hours.
            </p>
          </CardDark>
          <CardLight padding={28}>
            <div className="lbl-eyebrow">Concierge by default</div>
            <h3 className="h3" style={{ marginTop: 10 }}>Pre- and post-table arrangements.</h3>
            <p style={{ color: 'var(--text-mute-l)', marginTop: 10, fontSize: 14 }}>
              Tell us the occasion. We'll line up the small details — a tailor visit,
              a private soundcheck, the right table by the window — before you arrive.
            </p>
          </CardLight>
        </div>
      </section>
    </>
  );
}

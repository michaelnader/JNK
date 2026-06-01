import React from 'react';
import { Routes, Route, useLocation } from 'react-router-dom';
import { SiteHeader, SiteFooter } from './components/site.jsx';
import Home from './pages/Home.jsx';
import Restaurants from './pages/Restaurants.jsx';
import RestaurantDetail from './pages/RestaurantDetail.jsx';
import BookingDate from './pages/booking/Date.jsx';
import BookingTime from './pages/booking/Time.jsx';
import BookingOccasion from './pages/booking/Occasion.jsx';
import BookingReview from './pages/booking/Review.jsx';
import Payment from './pages/payment/Payment.jsx';
import AddCard from './pages/payment/AddCard.jsx';
import Confirmation from './pages/payment/Confirmation.jsx';
import Reservations from './pages/Reservations.jsx';
import NotFound from './pages/NotFound.jsx';

export default function App() {
  const location = useLocation();
  // Hero pages with full-bleed photo behind the header read as transparent.
  const transparentHeader = (
    location.pathname === '/' ||
    location.pathname.startsWith('/restaurants/') && !location.pathname.endsWith('/') ||
    location.pathname === '/confirmation'
  );
  // Reset scroll on every route change.
  React.useEffect(() => { window.scrollTo({ top: 0, behavior: 'instant' }); }, [location.pathname]);

  return (
    <>
      <SiteHeader transparent={transparentHeader}/>
      <main>
        <Routes>
          <Route path="/" element={<Home/>}/>
          <Route path="/restaurants" element={<Restaurants/>}/>
          <Route path="/restaurants/:id" element={<RestaurantDetail/>}/>

          <Route path="/book/date" element={<BookingDate/>}/>
          <Route path="/book/time" element={<BookingTime/>}/>
          <Route path="/book/occasion" element={<BookingOccasion/>}/>
          <Route path="/book/review" element={<BookingReview/>}/>

          <Route path="/payment" element={<Payment/>}/>
          <Route path="/payment/add" element={<AddCard/>}/>
          <Route path="/confirmation" element={<Confirmation/>}/>

          <Route path="/reservations" element={<Reservations/>}/>

          <Route path="*" element={<NotFound/>}/>
        </Routes>
      </main>
      <SiteFooter/>
    </>
  );
}

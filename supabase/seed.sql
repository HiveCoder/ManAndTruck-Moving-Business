-- ============================================================
--  ManAndTruck Movers — Seed Data
--  Run AFTER schema.sql
-- ============================================================

-- Services
INSERT INTO public.services (name, slug, short_description, description, icon_key, badge, featured, display_order) VALUES
('Local Moving',        'local-moving',       'Fast, efficient local moves within the city or metro area. Same-day availability on select dates.',              '<p>Whether you''re moving across town or just a few blocks away, ManAndTruck delivers a smooth, efficient local move. Our experienced crew handles all the heavy lifting, furniture disassembly, and careful placement so you can focus on settling into your new home.</p><ul><li>Full loading and unloading</li><li>Furniture disassembly & reassembly</li><li>Floor and door-frame protection</li><li>Same-day availability on select dates</li></ul>',   'truck-local',  'Most Popular', TRUE,  1),
('Long Distance',       'long-distance-moving','Interstate and cross-country moves with GPS tracking, dedicated trucks, and real-time updates.',                 '<p>Moving out of state? ManAndTruck coordinates long-distance moves with dedicated trucks, GPS tracking, and a single point of contact from quote to delivery. We handle the logistics so your move stays on schedule.</p><ul><li>Dedicated trucks — no shared loads</li><li>GPS tracking on every shipment</li><li>Real-time status updates</li><li>Full-value protection options</li></ul>',  'truck-long',   NULL,            TRUE,  2),
('Commercial Moving',   'commercial-moving',  'Office and business relocations scheduled to minimize downtime and disruption.',                                  '<p>Office and business moves require precision planning. Our commercial team works evenings and weekends to ensure zero downtime. From modular workstations to server racks, everything is labeled, moved, and reassembled exactly where you need it.</p><ul><li>After-hours and weekend scheduling</li><li>IT equipment handling</li><li>Modular furniture disassembly & setup</li><li>Dedicated project manager</li></ul>', 'building',     NULL,            TRUE,  3),
('Packing & Unpacking', 'packing-services',   'Professional packers who wrap, box, label, and unpack all your belongings — so you don''t have to.',              '<p>Let our professional packers handle every item in your home. We bring all the materials and ensure each box is clearly labeled and ready for a seamless unpack at your new address.</p><ul><li>Full or partial packing available</li><li>Specialty wrapping for fragile items</li><li>Clearly labeled boxes by room</li><li>Unpacking service available</li></ul>',           'box',          NULL,            FALSE, 4),
('Specialty Items',     'specialty-items',    'Pianos, fine art, antiques, and high-value items moved with custom crating and white-glove care.',                '<p>Some belongings require more than blanket wrapping. Our specialty team is trained to handle pianos, fine art, antiques, pool tables, and other high-value or awkward items with custom crating and white-glove service.</p><ul><li>Piano moving specialists</li><li>Custom wooden crating</li><li>Fine art handling & transport</li><li>Safe and vault moving</li></ul>',             'star',         NULL,            FALSE, 5),
('Storage Solutions',   'storage',            'Secure, climate-controlled short and long-term storage available while you''re between moves.',                   '<p>Need somewhere to store your belongings between moves? Our facilities are clean, climate-controlled, and monitored 24/7. Units come in a range of sizes to suit any need, from a few boxes to a full household.</p><ul><li>Climate-controlled units</li><li>24/7 video surveillance</li><li>Short and long-term options</li><li>Pick-up and delivery available</li></ul>',       'warehouse',    NULL,            FALSE, 6)
ON CONFLICT (slug) DO NOTHING;

-- Blog Posts
INSERT INTO public.blog_posts (title, slug, excerpt, content, category, published, published_at) VALUES
('The Ultimate Moving Checklist: 8 Weeks Before Your Move',
 'moving-checklist',
 'Start planning early to ensure a smooth move. Our comprehensive checklist covers every step from decluttering to utility transfers.',
 '<h2>8 Weeks Out</h2><p>Start by decluttering. Donate, sell, or discard anything you don''t need before you pack it. Schedule quotes from at least three moving companies.</p><h2>6 Weeks Out</h2><p>Book your mover. Confirm your moving date and get a written estimate. Begin collecting packing supplies.</p><h2>4 Weeks Out</h2><p>Notify your current and new utility providers. Update your address with the post office, bank, and subscriptions.</p><h2>2 Weeks Out</h2><p>Pack non-essentials. Label every box with its destination room and a brief contents list.</p><h2>Moving Day</h2><p>Keep a box of essentials (toiletries, documents, chargers) with you. Do a final walkthrough before the truck leaves.</p>',
 'Planning', TRUE, NOW() - INTERVAL ''7 days''),

('10 Pro Packing Tips to Protect Your Belongings',
 'packing-tips',
 'Learn how professional movers pack fragile items, how to label boxes efficiently, and what supplies you really need.',
 '<h2>1. Use the Right Box Size</h2><p>Heavy items go in small boxes; light items go in large boxes. This prevents back strain and box collapse.</p><h2>2. Wrap Fragile Items Individually</h2><p>Use packing paper (not newspaper — ink transfers) for dishes, glasses, and ceramics.</p><h2>3. Fill Empty Spaces</h2><p>Crumpled paper or bubble wrap prevents items from shifting and breaking in transit.</p><h2>4. Label Top AND Sides</h2><p>When boxes are stacked, you can only see the top. Label all visible sides.</p><h2>5. Pack a First-Night Box</h2><p>Include toiletries, a change of clothes, phone chargers, snacks, and any medications you need immediately.</p>',
 'Tips',     TRUE, NOW() - INTERVAL ''14 days''),

('How Much Does a Local Move Really Cost in 2025?',
 'moving-costs',
 'A breakdown of average moving costs by home size, distance, and add-on services — with tips on saving money.',
 '<h2>Average Local Moving Costs</h2><p>Local moves are typically billed hourly. In 2025, expect to pay $80–$120 per mover per hour, plus a truck fee.</p><table><tr><th>Home Size</th><th>Movers Needed</th><th>Hours</th><th>Estimate</th></tr><tr><td>Studio</td><td>2</td><td>2–3</td><td>$320–$720</td></tr><tr><td>1–2 Bedroom</td><td>2–3</td><td>3–5</td><td>$480–$1,800</td></tr><tr><td>3–4 Bedroom</td><td>3–4</td><td>5–8</td><td>$1,200–$3,840</td></tr></table><h2>Tips to Save</h2><ul><li>Book mid-week and avoid the 1st/last of the month</li><li>Declutter before moving day</li><li>Pack yourself to save on labor</li></ul>',
 'Costs',    TRUE, NOW() - INTERVAL ''21 days''),

('Moving with Kids: How to Make the Transition Easier',
 'moving-with-kids',
 'Practical advice for parents on preparing children for a move, keeping routines stable, and settling in quickly.',
 '<h2>Talk Early and Often</h2><p>Tell your children about the move as soon as it''s confirmed. Use age-appropriate language and emphasize the positives: a new room, a new neighborhood to explore.</p><h2>Involve Them in the Process</h2><p>Let kids pack their own "special box" of favorite toys and keepsakes. Having control over something reduces anxiety.</p><h2>Keep Routines Stable</h2><p>Maintain regular bedtimes, meals, and activities in the weeks leading up to and after the move.</p><h2>Explore the New Area Together</h2><p>Find the nearest park, ice cream shop, or library. Creating new positive associations helps children feel at home faster.</p>',
 'Family',   TRUE, NOW() - INTERVAL ''28 days'')
ON CONFLICT (slug) DO NOTHING;

-- Reviews
INSERT INTO public.reviews (author_name, location, rating, review_text, source, featured, approved) VALUES
('Sarah M.',   'Downtown',  5, 'ManAndTruck made our move completely stress-free. The team was professional, on time, and took great care of all our furniture. Highly recommend!', 'Google',  TRUE,  TRUE),
('James K.',   'Northside', 5, 'Second time using ManAndTruck and they deliver every time. Fair pricing, hard-working crew, and nothing was damaged. 5 stars all the way.',       'Yelp',    TRUE,  TRUE),
('Priya L.',   'Eastside',  5, 'I was nervous about moving my piano, but these guys handled it like pros. They brought the right equipment and got it done safely.',              'Google',  TRUE,  TRUE),
('Tom H.',     'Westside',  4, 'Great experience overall. The team was friendly and efficient. Only minor issue was a slight delay in arrival, but they called ahead.',            'Website', FALSE, TRUE),
('Angela R.',  'Downtown',  5, 'From the free quote to the final box unpacked, everything was handled with care and professionalism. Worth every penny.',                          'Google',  TRUE,  TRUE),
('Carlos D.',  'Northside', 5, 'Used them for an office move. They worked overnight and had everything set up by morning. Zero downtime for our business.',                       'Google',  TRUE,  TRUE),
('Mei L.',     'Eastside',  5, 'Super responsive from the first call. The crew wrapped every piece of furniture and nothing was scratched. Will definitely use them again.',       'Yelp',    FALSE, TRUE),
('David P.',   'Downtown',  5, 'Honest pricing, no hidden fees, great communication. Moving is stressful enough — ManAndTruck made it easy.',                                     'Google',  FALSE, TRUE)
ON CONFLICT DO NOTHING;

-- Locations
INSERT INTO public.locations (name, slug, description, address, phone, active, display_order) VALUES
('Downtown',  'downtown',  'Serving the downtown core and surrounding neighborhoods with fast, local expertise.', '123 Main St, Downtown, NY 10001',  '(555) 123-4567', TRUE, 1),
('Northside', 'northside', 'Covering all Northside neighborhoods, suburbs, and surrounding communities.',         '456 North Ave, Northside, NY 10002', '(555) 234-5678', TRUE, 2),
('Eastside',  'eastside',  'Your trusted local movers on the Eastside, ready for any size move.',                  '789 East Blvd, Eastside, NY 10003',  '(555) 345-6789', TRUE, 3),
('Westside',  'westside',  'Reliable, professional moving services across the entire Westside.',                   '321 West St, Westside, NY 10004',    '(555) 456-7890', TRUE, 4)
ON CONFLICT (slug) DO NOTHING;

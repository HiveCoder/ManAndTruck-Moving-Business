-- ============================================================
--  ManAndTruck Movers — Seed Data
--  Run AFTER schema.sql
-- ============================================================

-- Services
INSERT INTO public.services (name, slug, short_description, description, icon_key, badge, featured, display_order) VALUES
('Local Moving',        'local-moving',       'Fast, efficient local moves across Ontario, with strongest same-region coverage around Guelph and Waterloo Region.',              '<p>Whether you''re moving across town or between Ontario cities, ManAndTruck delivers a smooth, efficient move. Based in Guelph, our experienced crew handles heavy lifting, furniture disassembly, and careful placement so you can settle in faster.</p><ul><li>Full loading and unloading</li><li>Furniture disassembly & reassembly</li><li>Floor and door-frame protection</li><li>Weekend move scheduling available</li></ul>',   'truck-local',  'Most Popular', TRUE,  1),
('Long Distance',       'long-distance-moving','Province-wide and interprovincial moves with GPS tracking, dedicated trucks, and real-time updates.',                 '<p>Moving across Ontario or to a neighboring province? ManAndTruck coordinates long-distance moves with dedicated trucks, GPS tracking, and a single point of contact from quote to delivery. We handle the logistics so your move stays on schedule.</p><ul><li>Dedicated trucks - no shared loads</li><li>GPS tracking on every shipment</li><li>Real-time status updates</li><li>Full-value protection options</li></ul>',  'truck-long',   NULL,            TRUE,  2),
('Commercial Moving',   'commercial-moving',  'Office and business relocations scheduled to minimize downtime and disruption.',                                  '<p>Office and business moves require precision planning. Our commercial team works evenings and weekends to ensure zero downtime. From modular workstations to server racks, everything is labeled, moved, and reassembled exactly where you need it.</p><ul><li>After-hours and weekend scheduling</li><li>IT equipment handling</li><li>Modular furniture disassembly & setup</li><li>Dedicated project manager</li></ul>', 'building',     NULL,            TRUE,  3),
('Packing & Unpacking', 'packing-services',   'Professional packers who wrap, box, label, and unpack all your belongings — so you don''t have to.',              '<p>Let our professional packers handle every item in your home. We bring all the materials and ensure each box is clearly labeled and ready for a seamless unpack at your new address.</p><ul><li>Full or partial packing available</li><li>Specialty wrapping for fragile items</li><li>Clearly labeled boxes by room</li><li>Unpacking service available</li></ul>',           'boxes',        NULL,            FALSE, 4),
('Specialty Items',     'specialty-items',    'Pianos, fine art, antiques, and high-value items moved with custom crating and white-glove care.',                '<p>Some belongings require more than blanket wrapping. Our specialty team is trained to handle pianos, fine art, antiques, pool tables, and other high-value or awkward items with custom crating and white-glove service.</p><ul><li>Piano moving specialists</li><li>Custom wooden crating</li><li>Fine art handling & transport</li><li>Safe and vault moving</li></ul>',             'star',         NULL,            FALSE, 5),
('Storage Solutions',   'storage',            'Secure, climate-controlled short and long-term storage available while you''re between moves.',                   '<p>Need somewhere to store your belongings between moves? Our facilities are clean, climate-controlled, and monitored 24/7. Units come in a range of sizes to suit any need, from a few boxes to a full household.</p><ul><li>Climate-controlled units</li><li>24/7 video surveillance</li><li>Short and long-term options</li><li>Pick-up and delivery available</li></ul>',       'warehouse',    NULL,            FALSE, 6),
('Cleaning Services',    'cleaning-services',  'Professional move-in, move-out, and deep cleaning for homes and offices — leaving your space spotless before or after your move.',  '<p>Our certified cleaning crews take care of every corner — from appliances and baseboards to windows and bathrooms — so you can hand over or take possession of your property with full confidence.</p><ul><li>Move-in and move-out cleans</li><li>Deep cleaning for kitchens and bathrooms</li><li>Post-renovation cleanup</li><li>Eco-friendly, pet-safe cleaning products</li><li>Flexible scheduling alongside your move</li></ul>',  'cleaning',     'New Service',   TRUE,  7)
ON CONFLICT (slug) DO UPDATE
SET
	name = EXCLUDED.name,
	short_description = EXCLUDED.short_description,
	description = EXCLUDED.description,
	icon_key = EXCLUDED.icon_key,
	badge = EXCLUDED.badge,
	featured = EXCLUDED.featured,
	display_order = EXCLUDED.display_order;

-- Blog Posts
INSERT INTO public.blog_posts (title, slug, excerpt, content, category, published, published_at) VALUES
('Ontario Moving Timeline: The 30-Day Plan That Keeps You On Track',
 'ontario-moving-timeline-30-day-plan',
 'A practical, week-by-week action plan for Ontario households moving within or between cities like Guelph, Kitchener, and Toronto.',
 '<h2>30 Days Before Move Day</h2><p>Confirm your moving date, request quotes, and sort items into keep, donate, and recycle categories. Early planning reduces stress and helps avoid rush costs.</p><h2>21 Days Before</h2><p>Book your mover, gather packing supplies, and start with low-use rooms. Label boxes by room and priority level to speed up unloading.</p><h2>14 Days Before</h2><p>Transfer utilities, update mailing addresses, and confirm building requirements such as elevator bookings or loading permits.</p><h2>7 Days Before</h2><p>Pack essentials separately, defrost appliances if needed, and prepare a first-night bag with toiletries, chargers, documents, and medication.</p><h2>Move Weekend</h2><p>Do a final walkthrough, keep key documents with you, and share any special handling instructions with your crew before loading begins.</p>',
 'Planning', TRUE, NOW() - INTERVAL '7 days'),

('Packing Like a Pro: 12 Techniques to Prevent Damage in Transit',
 'packing-like-a-pro-12-techniques',
 'Learn professional packing methods that protect dishes, electronics, and furniture while making unpacking faster and cleaner.',
 '<h2>Use the Right Box for the Right Item</h2><p>Heavy books belong in small boxes, while bedding and light items belong in larger boxes. This keeps boxes safer to lift and stack.</p><h2>Protect Breakables with Layers</h2><p>Wrap fragile items individually and fill gaps so contents cannot shift while the truck is in motion.</p><h2>Label Clearly and Consistently</h2><p>Use large labels on multiple sides and include destination room plus handling notes such as FRAGILE or THIS SIDE UP.</p><h2>Create an Essentials Zone</h2><p>Set aside daily-use items for the first 24 hours so you are not opening every carton on arrival day.</p>',
 'Tips',     TRUE, NOW() - INTERVAL '14 days'),

('What Impacts Moving Costs in Ontario and How to Budget Accurately',
 'ontario-moving-cost-factors-budget-guide',
 'Understand the biggest pricing drivers, from distance and access conditions to packing scope and specialty-item handling.',
 '<h2>Distance and Travel Time</h2><p>Local moves are commonly priced by crew time, while longer routes include distance and scheduling factors.</p><h2>Access Conditions Matter</h2><p>Stairs, elevator restrictions, long carry distances, and limited parking can increase labor time. Share these details during quoting for accurate pricing.</p><h2>Service Scope Changes Cost</h2><p>Full packing, unpacking, and storage can save effort and reduce risk, but should be budgeted in advance for transparency.</p><h2>How to Keep Costs Predictable</h2><ul><li>Declutter before packing</li><li>Prepare access and parking early</li><li>Choose a realistic move-day schedule</li><li>Request written quote details</li></ul>',
 'Costs',    TRUE, NOW() - INTERVAL '21 days'),

('Moving with Kids in Ontario: A Family-Friendly Transition Guide',
 'moving-with-kids-ontario-guide',
 'Keep routines stable, reduce anxiety, and help children settle into a new neighborhood with less disruption.',
 '<h2>Start Conversations Early</h2><p>Explain what is changing and what will stay the same. Clear, calm communication helps children feel secure.</p><h2>Give Kids a Role</h2><p>Let children pack a comfort box with favorite items to keep accessible during move day.</p><h2>Protect Key Routines</h2><p>Maintain meal and bedtime routines as much as possible during moving week to reduce overwhelm.</p><h2>Build Familiarity Quickly</h2><p>In your first week, visit nearby parks, grocery stores, and community spaces to make the new area feel familiar sooner.</p>',
 'Family',   TRUE, NOW() - INTERVAL '28 days')
ON CONFLICT (slug) DO UPDATE
SET
	title = EXCLUDED.title,
	excerpt = EXCLUDED.excerpt,
	content = EXCLUDED.content,
	category = EXCLUDED.category,
	published = EXCLUDED.published,
	published_at = EXCLUDED.published_at;

-- Reviews
INSERT INTO public.reviews (author_name, location, rating, review_text, source, featured, approved) VALUES
('Sarah M.',   'Guelph',       5, 'ManAndTruck made our move completely stress-free. The team was professional, on time, and took great care of all our furniture. Highly recommend!', 'Google',  TRUE,  TRUE),
('James K.',   'Kitchener',    5, 'Second time using ManAndTruck and they deliver every time. Fair pricing, hard-working crew, and nothing was damaged. 5 stars all the way.',       'Yelp',    TRUE,  TRUE),
('Priya L.',   'Waterloo',     5, 'I was nervous about moving my piano, but these guys handled it like pros. They brought the right equipment and got it done safely.',              'Google',  TRUE,  TRUE),
('Tom H.',     'Cambridge',    4, 'Great experience overall. The team was friendly and efficient. Only minor issue was a slight delay in arrival, but they called ahead.',            'Website', FALSE, TRUE),
('Angela R.',  'Guelph',       5, 'From the free quote to the final box unpacked, everything was handled with care and professionalism. Worth every penny.',                          'Google',  TRUE,  TRUE),
('Carlos D.',  'London',       5, 'Used them for an office move. They worked overnight and had everything set up by morning. Zero downtime for our business.',                       'Google',  TRUE,  TRUE),
('Mei L.',     'Hamilton',     5, 'Super responsive from the first call. The crew wrapped every piece of furniture and nothing was scratched. Will definitely use them again.',       'Yelp',    FALSE, TRUE),
('David P.',   'Ottawa',       5, 'Honest pricing, no hidden fees, great communication. Moving is stressful enough - ManAndTruck made it easy.',                                     'Google',  FALSE, TRUE)
ON CONFLICT DO NOTHING;

-- Locations
INSERT INTO public.locations (name, slug, description, address, phone, active, display_order) VALUES
('Guelph',       'guelph',       'Head office location and primary dispatch hub for moves across Ontario.',                        '1 Carden St, Guelph, ON N1H 3A1',               '(519) 555-0136', TRUE, 1),
('Kitchener',    'kitchener',    'Serving Kitchener neighborhoods, condos, and business relocations.',                            '200 King St W, Kitchener, ON N2G 4G7',          '(519) 555-0142', TRUE, 2),
('Waterloo',     'waterloo',     'Trusted local moving support across Waterloo and nearby communities.',                         '75 King St S, Waterloo, ON N2J 1P2',            '(519) 555-0154', TRUE, 3),
('Cambridge',    'cambridge',    'Professional residential and commercial moving services throughout Cambridge.',                 '50 Dickson St, Cambridge, ON N1R 8S1',          '(519) 555-0168', TRUE, 4),
('Milton',       'milton',       'Reliable moving support across Milton and surrounding Halton communities.',                    '150 Mary St, Milton, ON L9T 1N6',               '(905) 555-0172', TRUE, 5),
('Hamilton',     'hamilton',     'Full-service moving crews for homes and businesses across Hamilton.',                          '71 Main St W, Hamilton, ON L8P 4Y5',            '(905) 555-0181', TRUE, 6),
('Brantford',    'brantford',    'Local and long-distance moves from Brantford to cities across Ontario.',                       '100 Wellington Sq, Brantford, ON N3T 2L9',      '(519) 555-0193', TRUE, 7),
('Mississauga',  'mississauga',  'Covering Mississauga neighborhoods and nearby communities with reliable moving support.',     '100 City Centre Dr, Mississauga, ON L5B 2C9',   '(905) 555-0142', TRUE, 8),
('Toronto',      'toronto',      'Serving Toronto neighborhoods with careful planning and experienced crews.',                    '120 King St W, Toronto, ON M5H 1J9',            '(416) 555-0136', TRUE, 9),
('London',       'london',       'Serving London with weekend moving availability and flexible move planning.',                   '300 Dufferin Ave, London, ON N6B 1Z2',          '(519) 555-0204', TRUE, 10),
('Ottawa',       'ottawa',       'Province-wide and intercity move coordination for Ottawa homes and offices.',                  '110 Laurier Ave W, Ottawa, ON K1P 1J1',         '(613) 555-0117', TRUE, 11),
('Windsor',      'windsor',      'Ontario-wide moving support for Windsor and Essex region customers.',                          '350 City Hall Sq W, Windsor, ON N9A 7K6',       '(519) 555-0228', TRUE, 12)
ON CONFLICT (slug) DO UPDATE
SET
	name = EXCLUDED.name,
	description = EXCLUDED.description,
	address = EXCLUDED.address,
	phone = EXCLUDED.phone,
	active = EXCLUDED.active,
	display_order = EXCLUDED.display_order;

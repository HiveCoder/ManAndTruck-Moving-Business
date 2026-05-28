<template>
  <svg viewBox="0 0 520 320" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
    <!-- Road -->
    <rect x="0" y="270" width="520" height="50" rx="4" fill="#1a2e47"/>
    <rect x="0" y="275" width="520" height="4" rx="2" fill="#253e5e"/>
    <!-- Dashes -->
    <rect x="40"  y="293" width="60" height="5" rx="2.5" fill="#fff" opacity=".25"/>
    <rect x="160" y="293" width="60" height="5" rx="2.5" fill="#fff" opacity=".25"/>
    <rect x="280" y="293" width="60" height="5" rx="2.5" fill="#fff" opacity=".25"/>
    <rect x="400" y="293" width="60" height="5" rx="2.5" fill="#fff" opacity=".25"/>
    <!-- Truck cab -->
    <rect x="50"  y="160" width="180" height="110" rx="10" fill="#1d3557"/>
    <!-- Cargo box -->
    <rect x="230" y="130" width="240" height="140" rx="8" fill="#2a9d8f"/>
    <!-- Cab window -->
    <rect x="70"  y="175" width="80"  height="50"  rx="6"  fill="#94e4da" opacity=".8"/>
    <!-- Cab door line -->
    <line x1="190" y1="165" x2="190" y2="270" stroke="#1a2e47" stroke-width="3"/>
    <!-- Cargo door detail -->
    <line x1="350" y1="140" x2="350" y2="270" stroke="#1a2e47" stroke-width="2.5" opacity=".4"/>
    <line x1="350" y1="205" x2="470" y2="205" stroke="#1a2e47" stroke-width="2.5" opacity=".4"/>
    <!-- Wheels -->
    <circle cx="110" cy="274" r="28" fill="#122640"/>
    <circle cx="110" cy="274" r="14" fill="#94e4da"/>
    <circle cx="110" cy="274" r="6"  fill="#1d3557"/>
    <circle cx="310" cy="274" r="28" fill="#122640"/>
    <circle cx="310" cy="274" r="14" fill="#94e4da"/>
    <circle cx="310" cy="274" r="6"  fill="#1d3557"/>
    <circle cx="400" cy="274" r="28" fill="#122640"/>
    <circle cx="400" cy="274" r="14" fill="#94e4da"/>
    <circle cx="400" cy="274" r="6"  fill="#1d3557"/>
    <!-- Headlight -->
    <rect x="52"  y="195" width="12" height="22" rx="4" fill="#ffd166" opacity=".9"/>
    <!-- Side mirror -->
    <rect x="42"  y="173" width="14" height="8"  rx="2" fill="#2a9d8f"/>
    <!-- Cargo box branding -->
    <text x="262" y="198" font-family="Oswald,sans-serif" font-size="16" font-weight="700" fill="#fff" letter-spacing="1" opacity=".9">MAN &amp; TRUCK</text>
    <text x="262" y="216" font-family="Open Sans,sans-serif" font-size="9"  font-weight="600" fill="#94e4da" letter-spacing="2" opacity=".9">MOVING &amp; CLEANING</text>
    <!-- Phone number on truck -->
    <text x="262" y="240" font-family="Open Sans,sans-serif" font-size="11" fill="#fff" opacity=".7">(416) 555-0136</text>
    <!-- Cleaning sparkle icons on cargo box -->
    <path d="M460 148 L462.5 155 L470 157.5 L462.5 160 L460 167 L457.5 160 L450 157.5 L457.5 155 Z" fill="#fff" opacity=".5"/>
    <path d="M476 140 L477.2 143.8 L481 145 L477.2 146.2 L476 150 L474.8 146.2 L471 145 L474.8 143.8 Z" fill="#fff" opacity=".35"/>
    <!-- Stars and rating -->
    <text x="160" y="115" font-size="22" fill="#ffd166">★★★★★</text>
    <text x="162" y="135" font-family="Open Sans,sans-serif" font-size="10" fill="#94e4da" letter-spacing="1">Rated #1 Moving &amp; Cleaning</text>
  </svg>
</template>

# send-lead-email (Supabase Edge Function)

Server-side lead email relay using Resend.

## Required secrets

Set these in your Supabase project:

- `RESEND_API_KEY` (required)
- `LEAD_TO_EMAIL` (optional, defaults to request `to` or `underspecific@gmail.com`)
- `RESEND_FROM_EMAIL` (optional, defaults to `ManAndTruck Movers <onboarding@resend.dev>`)

## Deploy

```powershell
npx supabase functions deploy send-lead-email --project-ref oytuwumixjnpcwqnsxpg
```

## Set secrets

```powershell
npx supabase secrets set RESEND_API_KEY=YOUR_KEY --project-ref oytuwumixjnpcwqnsxpg
npx supabase secrets set LEAD_TO_EMAIL=underspecific@gmail.com --project-ref oytuwumixjnpcwqnsxpg
npx supabase secrets set RESEND_FROM_EMAIL="ManAndTruck Movers <onboarding@resend.dev>" --project-ref oytuwumixjnpcwqnsxpg
```

## Function payload

Expected JSON payload from frontend:

```json
{
  "to": "underspecific@gmail.com",
  "subject": "New Inquiry",
  "text": "Lead details...",
  "name": "Customer Name",
  "replyTo": "customer@example.com"
}
```

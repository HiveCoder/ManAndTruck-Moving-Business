# send-lead-email (Supabase Edge Function)

Server-side lead email relay using Brevo (preferred) with Resend fallback.

## Required secrets

Set these in your Supabase project:

- `BREVO_API_KEY` (recommended)
- `RESEND_API_KEY` (optional fallback)
- `LEAD_TO_EMAIL` (optional, defaults to request `to` or `underspecific@gmail.com`)
- `MAIL_FROM_EMAIL` (optional shared sender identity for either provider)
- `BREVO_FROM_EMAIL` (optional Brevo sender identity if `MAIL_FROM_EMAIL` is not set)
- `RESEND_FROM_EMAIL` (optional Resend sender identity if `MAIL_FROM_EMAIL` is not set)

## Deploy

```powershell
npx supabase functions deploy send-lead-email --project-ref oytuwumixjnpcwqnsxpg
```

## Set secrets

```powershell
npx supabase secrets set BREVO_API_KEY=YOUR_BREVO_KEY --project-ref oytuwumixjnpcwqnsxpg
npx supabase secrets set LEAD_TO_EMAIL=underspecific@gmail.com --project-ref oytuwumixjnpcwqnsxpg
npx supabase secrets set MAIL_FROM_EMAIL="ManAndTruck Movers <your-verified-sender@example.com>" --project-ref oytuwumixjnpcwqnsxpg
```

Optional fallback (if you still want Resend available):

```powershell
npx supabase secrets set RESEND_API_KEY=YOUR_RESEND_KEY --project-ref oytuwumixjnpcwqnsxpg
```

## Brevo setup notes

- In Brevo, verify a sender email first (this can be a regular email address).
- Use that same verified address in `MAIL_FROM_EMAIL`.
- `LEAD_TO_EMAIL` can stay as `underspecific@gmail.com`.

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

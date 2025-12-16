# Email Confirmation Setup

## Fix the Redirect URL Issue

After confirming your email, Supabase redirects to a confirmation page. Here's how to set it up:

### Step 1: Upload confirm.html

Make sure `confirm.html` is in the same directory as `index.html` on your server/hosting.

### Step 2: Update Supabase Redirect URL

1. Go to your **Supabase Dashboard**
2. Navigate to **Authentication** → **URL Configuration**
3. Under **Redirect URLs**, add:
   - If running locally with Live Server: `http://127.0.0.1:5500/confirm.html` (or whatever port)
   - If hosting on GitHub Pages: `https://yourusername.github.io/yourrepo/confirm.html`
   - If hosting elsewhere: `https://yourdomain.com/confirm.html`
4. Also set **Site URL** to your main app URL (e.g., `http://127.0.0.1:5500/index.html`)
5. Click **Save**

### Step 3: Test

1. Sign up with a new email
2. Check your email and click the confirmation link
3. You should be redirected to the nice confirmation page instead of localhost:3000

## Notes

- The confirmation page automatically signs you in and redirects to the main app after 3 seconds
- You can also click the button to go immediately
- All error cases are handled with friendly messages


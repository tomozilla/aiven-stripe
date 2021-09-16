# Multi-currency eCommerce web app (Automatic Payment Methods)

This sample is a full stack web app built with RoR. This eCommerce app shows checkout and elemenets with Automatic Payment Methods. 

## Prerequsite
1. Enable your accounts for Automatic Payment Methods. Ask #automatic-payment-methods for more details.

2. Install Ngrok for proxy.

3. Ruby 2.6.3

4. Postgres

## How to run
Follow the steps below to run locally.

1. Clone the repository:

git clone https://github.com/tmitani-stripe/fj

2. Copy the .env.example to a .env file:

cp .env.example .env

You will need a Stripe account in order to run the demo. Once you set up your account, go to the Stripe developer dashboard to find your API keys.

STRIPE_PUBLISHABLE_KEY=<replace-with-your-publishable-key>

STRIPE_SECRET_KEY=<replace-with-your-secret-key>

STRIPE_WEBHOOK_SECRET_KEY=<replace-with-your-webhook-secret-key>

NGROK_URL=<replace-with-your-ngrok-domain-name>

3. Change webhook endpoint with ngrok domain on Stripe Dashboard:

4. `rails:db create`

5. `rails:db migrate`

6. `rails:db seed`

7. `bundle install`

8. `yarn install`

9. `rails s` 

10. Open localhost:3000 on your browser

Author(s)
@tmitani
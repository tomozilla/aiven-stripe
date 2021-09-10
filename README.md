1. bundle install
2. yarn install
3. rails s

## Overview of Application
A user logins the e-commerce application and will land on the homepage. The homepage shows all the products from the database, and the user can select a product to see more explanations and details. The product page explains details and shows the price of a product, and the user can put the item in the shopping cart. The shopping cart page displays items in the shopping cart for the current user. At this time, an order is created for the user. The user can also change the quantity of items in the shopping cart, and then they proceed to checkout to the application’s checkout page. The figure below shows the database model for this application.

![models](./img/model_new.png?raw=true "Database Model")

In the checkout page, the application creates Stripe’s checkout session with Stripe API ([POST  /v1/checkout/sessions](https://stripe.com/docs/api/checkout/sessions#create_checkout_session)), and it saves Payment Intent ID from this session to the associated order in the database. The payment page will show products,  quantities, and the total price to be charged. The application’s front end creates an instance of the Stripe object so that the user is going to be redirected with the Checkout Session ID to Stripe’s payment page when the user clicks the pay button.

Stripe uses a credit card form asking credit card number, cvv, and expiration date so that the user has to fill out credit card information in the secured Stripe inputs. When the payment is successful and the status of Payment Intent changes, Stripe sends a webhook event; [payment_intent.succeeded](https://stripe.com/docs/api/events/types#event_types-payment_intent.succeeded) to the application. The backend process of the application changes the status of the order from ‘cart’ to ‘paid’, and saves Stripe Charge Id to the order when this webhook event is notified. Finally the user is redirected to the confirmation page on the application which displays the order summary with the total price and Stripe Charge ID.

![flow](./img/new_flow.png?raw=true "Process Flow")

The above process flow shows the integration between the e-commerce application and Stripe. An order is created with status = ‘cart’ when the user goes to the shopping page. Checkout Session is created with Stripe in the application's checkout page. Finally when the payment is successfully completed, Stripe sends a webhook event, and the application updates the status of the order to ‘paid’.




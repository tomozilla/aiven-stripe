## Overview of Application
A user logins the e-commerce application and will land on the homepage. The homepage shows all the products from the database, and the user can select a product to see more explanations and details. The product page explains details and shows the price of a product, and the user can put the item in the shopping cart. The shopping cart page displays items in the shopping cart for the current user. At the same time, an order is created for the user. The user can also change the quantity of items in the shopping cart, and then they proceed to checkout to the application’s payment page. The figure below shows the database model for this application.

![models](./img/model_new.png?raw=true "Database Model")

After checking out, the application creates Stripe’s checkout session with Stripe API ([POST  /v1/checkout/sessions](https://stripe.com/docs/api/checkout/sessions#create_checkout_session)), and it saves Payment Intent ID from this session to the associated order in the database. The payment page will show products,  quantities, and the total price to be charged. The application’s front end creates an instance of the Stripe object so that the user is going to be redirected with the Checkout Session ID to Stripe’s payment page when the user clicks the pay button.

Stripe uses a credit card form asking credit card number, cvv, and expiration date. So the user has to fill out credit card information in the secured Stripe inputs. When the user clicks the pay button, Stripe sends a webhook event; [payment_intent.created](https://stripe.com/docs/api/events/types#event_types-payment_intent.created) to the application, and the application changes the status of the order to ‘penging’. Finally, when the payment is successful and the status of Payment Intent changes, Stripe sends a webhook event; [payment_intent.succeeded](https://stripe.com/docs/api/events/types#event_types-payment_intent.succeeded) to the application. The backend process of the application changes the status of the order from ‘pending’ to ‘paid’, and saves Stripe Charge Id to the order when this webhook event is notified. Finally the user is redirected to the confirmation page on the application which displays the order summary with Stripe Charge ID.

![flow](./img/flow.png?raw=true "Process Flow")

The above process flow shows the integration between e-commerce application and Stripe. An order is created with status = ‘cart’ when the user goes to the shopping page. Stripe sends a webhook event to the application when a new payment intent is created in Stripe, and the application updates the status of the order from ‘cart’ to ‘pending’. Finally when the payment is successfully completed, Stripe sends another webhook event, and the application updates the status of the order to ‘paid’.

## Approaches

The first part of the approaches was creating the user story in order to meet this project’s requirements and the customer journey. I created a rough wireframe in my notebook and database models in order for users to put shopping items into a shopping cart and then to check out their shopping carts to make the payment. Second part is to integrate the e-commerce application with Stripe. I carefully went through Stripe’s API documentations and read some code examples. Then, trying Stripe API helped me understand the payment process and the business flow. I was able to finalize the process flow of the interaction between the e-commerce application and Stripe payment system.

## Language and Framework

Ruby on Rails was used to build this application. Ruby is a general-purpose, high-level language that allows developers to write concise and readable code to achieve similar, high-quality results when it comes to building web apps. The popularity of Ruby is very high in Japan, and many startups still choose Ruby on Rails for their main language. Choosing Ruby on Rails for this type of demo applications will resonate with the wider Japanese developer’s community, and the demo application will show how it will integrate with Stripe payment system. 

## Possible Extensions to Make the Application More Robust

There are three areas that can extend to build a more robust application; error handlings, security, and scalability. First, the application can subscribe to more event webhooks to handle more errors. Moreover, in case there is an incident in Stripe, the client should receive an appropriate error in their browser. This can also be extended to the operational team so that they can provide manual intervention if needed.

Security should be another important area to focus to improve the application. More secure authentications are necessary to provide users. This can mean adding two factor authentications or OAuth based sign in with third parties such as Google or Twitter. Proper authorization needs to take a place in order to provide proper access permissions to their resources. Customer data in the database can be encrypted to be protected more securely. Data in transient is encrypted, but encryption data in rest can be considered according to the business requirements.

Finally, in order to handle the spikes of the traffic, the production application needs to be scalable. The application can scale their instances within seconds by using containers for its runtime. With the proper autoscale behavior, it can scale when it needs, and this also saves a lot of resources. In order to utilize maximum resources; memory and CPU, fine tunings of configurations are necessary to work more concurrencies.



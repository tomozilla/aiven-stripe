## Overview of Application
A user logins the e-commerce application and will land on the homepage. The homepage shows all the products from the database, and the user can select a product to see more explanations and details. The product page explains details and shows the price of a product, and the user can put the item in the shopping cart. The shopping cart page displays items in the shopping cart for the current user. At this time, an order is created for the user. The user can also change the quantity of items in the shopping cart, and then they proceed to checkout to the application’s checkout page. The figure below shows the database model for this application.

![models](./img/model_new.png?raw=true "Database Model")

In the checkout page, the application creates Stripe’s checkout session with Stripe API ([POST  /v1/checkout/sessions](https://stripe.com/docs/api/checkout/sessions#create_checkout_session)), and it saves Payment Intent ID from this session to the associated order in the database. The payment page will show products,  quantities, and the total price to be charged. The application’s front end creates an instance of the Stripe object so that the user is going to be redirected with the Checkout Session ID to Stripe’s payment page when the user clicks the pay button.

Stripe uses a credit card form asking credit card number, cvv, and expiration date so that the user has to fill out credit card information in the secured Stripe inputs. When the payment is successful and the status of Payment Intent changes, Stripe sends a webhook event; [payment_intent.succeeded](https://stripe.com/docs/api/events/types#event_types-payment_intent.succeeded) to the application. The backend process of the application changes the status of the order from ‘cart’ to ‘paid’, and saves Stripe Charge Id to the order when this webhook event is notified. Finally the user is redirected to the confirmation page on the application which displays the order summary with the total price and Stripe Charge ID.

![flow](./img/latestgit_flow.png?raw=true "Process Flow")

The above process flow shows the integration between the e-commerce application and Stripe. An order is created with status = ‘cart’ when the user goes to the shopping page. Checkout Session is created with Stripe in the application's checkout page. Finally when the payment is successfully completed, Stripe sends a webhook event, and the application updates the status of the order to ‘paid’.

## Approaches

The first part of the approaches was creating the user story in order to meet this project’s requirements. I created a rough wireframe and database model on my notebook in order for users to put shopping items into a shopping cart and then to check out their shopping carts to make the payment. The second part is integrating the e-commerce application with Stripe. I went through Stripe’s API documentations and read some sample codes in Ruby. Trying actual Stripe APIs and Stripe's dashboard helped me understand how the payment process and the business flow work. After that, I was able to finalize the process flow of the interaction between the e-commerce application and Stripe payment system. I made sure that the first part of the approaches works in my codes first, and started writing the rest of codes once I figured out the technical details of the integration part.

## Language and Framework

Ruby on Rails was used to build this application. Ruby is a general-purpose, high-level language that allows developers to write concise and readable code to achieve similar, high-quality results when it comes to building web apps. The popularity of Ruby is very high in Japan, and many startups still choose Ruby on Rails for their main language. Choosing Ruby on Rails for this type of demo applications will resonate with the wider Japanese developer’s community, and the demo application will show the audience how it will integrate with Stripe payment system. 

## Possible Extensions to Make the Application More Robust

There are three areas that can be extended to build a more robust application; error handling, security, and scalability. First, the application can subscribe to more event webhooks such as 'payment_intent.payment_failed' or 'payment_intent.canceled' to handle more errors in case of payment's failures. Moreover, when there is an incident in Stripe, the client should receive an appropriate error in their browser. This can also be extended to the operational team so that they can provide manual intervention if needed.

Security should be another important area to focus to improve the application. More secure authentications are necessary to provide users. This can mean adding two factor authentications or OAuth based sign in with third parties such as Google or Twitter. Also, Proper authorization needs to take a place in order to provide proper access permissions to their resources. Customer data in the database can be encrypted to be protected more securely. Data in transient is encrypted, but encryption data in rest can be considered according to the business requirements.

Finally, in order to handle the spikes of the traffic, the production application needs to be scalable. The application can scale their instances within seconds by using containers for its runtime. With the proper autoscale behavior, it can scale when it needs, and this also saves a lot of resources. In order to utilize maximum resources; memory and CPUs, fine tunings of configurations are necessary to work more concurrencies.



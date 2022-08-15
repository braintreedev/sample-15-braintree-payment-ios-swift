<h2>This repo is on a path to being archived, checkout our other resources in github.com/paypal</h2>

# Using the Braintree Client SDK for iOS

This is an example of the Braintree v.zero Client SDK for processing both PayPal and credit card payments in iOS applications. It comes with a minimal backened example written in Node.js that shows how to generate client tokens and how to process the payment method nonce.

## Technology

This demo uses

* iOS 7+
* [AFNetworking](http://github.com/AFNetworking/AFNetworking)
* [Braintree Client SDK for iOS](http://github.com/braintree/braintree_ios)
* [CocoaPods](http://cocoapods.org/)

The sample backend is written in Node.js and uses:

* Node 0.10.26 or higher
* The [Express](http://expressjs.com/) web framework
* The [Braintree Node SDK](http://github.com/braintree/braintree_node)

## Running the server

* In the `server` folder
	* Run `npm install` to install all dependencies
	* Run `npm start` to start the Express app

## Running the mobile app (Device / Emulator)

* In the `client` folder
	* Run `pod install` to install all dependencies.
	* Open the newly created file `vzero.xcworkspace` in your XCode. 
	* Build the app and run it in your emulator or on your device
		* *Once the app started it will try to get the client token from your backend. Ensure that your server is already running before you launch the mobile application.*
	* Click on `Start Payment`
	* Select either of these payment methods:
		* (PayPal) 
			* Fill in the following credentials:
				* Email: `us-customer@commercefactory.org`
				* Password: `test1234`
			* Click `Agree` to accept future payments
		* (Credit Card) Fill in the following credentials:
			* Number: `4111 1111 1111 1111`
			* Expiration date: `11/15`
  			* CVV: `123`
	* Click on `Pay`
	* You will see a message that says __"Transaction ID: [transaction_id]"__

## Useful links

* [Full documentation for the Braintree Client SDK for iOS+Node](https://developers.braintreepayments.com/ios+node/start/overview) 

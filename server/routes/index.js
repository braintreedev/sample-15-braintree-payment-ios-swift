var express = require('express');
var router = express.Router();
var braintree = require('braintree');

var gateway = braintree.connect({
  environment: braintree.Environment.Sandbox,
  merchantId: "ffdqc9fyffn7yn2j",
  publicKey: "qj65nndbnn6qyjkp",
  privateKey: "a3de3bb7dddf68ed3c33f4eb6d9579ca"
});

/* POST Creates a new token and returns it in the response */
router.get('/token', function (req, res) {
  gateway.clientToken.generate(null, function (error, response) {
    res.json(response);
  });
});

/* POST Handles the amount & payment method nonce to execute a transaction */
router.post('/payment', function (req, res) {
  var sale = {
    amount: "10",
    payment_method_nonce: req.param('payment_method_nonce')
  };

  gateway.transaction.sale(sale, function (error, response) {
    if (!error && response.success) {
      res.json(response);
    } else {
      // show an error message
    }
  });
});

module.exports = router;

<?php

require '../config.php';

$productid = $_POST['productid'];
$name = $_POST['itemname'];
$description = $_POST['paypaldesc'];

/* ### Comment below 4 lines and uncomment below mysqli code 
       if you want to fetch product information from database
*/
$price = intval($_POST['itemprice']);
$shipping = intval($_POST['shipping']);
$tax = intval($_POST['tax']);
$currency = $_POST['currencycode'];


    #### GET PRODUCT INFORMATION ###
    //Create new table and stre infromation in it for mysqli code to work   
  
    //Open a new connection to the MySQL server
    $mysqli = new mysqli($strDBHost, $strDBUser, $strDBPass, $strDBName);
   
    //Output any connection error
    if ($mysqli->connect_error) {
        die('Error : (' . $mysqli->connect_errno . ') ' . $mysqli->connect_error);
    }      
   
    $product_info = $mysqli->query("SELECT * FROM paypal_products WHERE product_id = '" . $mysqli->real_escape_string($productid) . "'");
   
    if ($product_info->num_rows() > 0) {
        $row = $product_info->fetch_assoc();
        
        // Assign values fetched from database
        $price = intval($row['itemprice']);
        $shipping = intval($row['shipping']);
        $tax = intval($row['tax']);
        $currency = $row['currencycode'];
    } else {
        die('Error : (' . $mysqli->errno . ') ' . $mysqli->error);
    }
   


// calculate sub total
$subtotal = $price;

// Calculate total ammount paypable
$totalprice = $subtotal + $shipping + $tax;


// # Create Payment using PayPal as payment method
// This sample code demonstrates how you can process a 
// PayPal Account based Payment.
// API used: /v1/payments/payment

require __DIR__ . '/bootstrap.php';

use PayPal\Api\Amount;
use PayPal\Api\Details;
use PayPal\Api\Item;
use PayPal\Api\ItemList;
use PayPal\Api\Payer;
use PayPal\Api\Payment;
use PayPal\Api\RedirectUrls;
use PayPal\Api\Transaction;
session_start();

// ### Payer
// A resource representing a Payer that funds a payment
// For paypal account payments, set payment method
// to 'paypal'.
$payer = new Payer();
$payer->setPaymentMethod("paypal");

// ### Itemized information
// (Optional) Lets you specify item wise
// information
$item1 = new Item();
$item1->setName($name)
	->setCurrency($currency)
	->setPrice($price);
//$item2 = new Item();
//$item2->setName('Granola bars')
//	->setCurrency('USD')
//	->setQuantity(5)
//	->setPrice('2.00');

$itemList = new ItemList();
//$itemList->setItems(array($item1, $item2));
$itemList->setItems(array($item1));


// ### Additional payment details
// Use this optional field to set additional
// payment information such as tax, shipping
// charges etc.

$details = new Details();
$details->setShipping($shipping)
	->setTax($tax)
	->setSubtotal($subtotal);



// ### Amount
// Lets you specify a payment amount.
// You can also specify additional details
// such as shipping, tax.
$amount = new Amount();
$amount->setCurrency($currency)
	->setTotal($totalprice)
	->setDetails($details);

// ### Transaction
// A transaction defines the contract of a
// payment - what is the payment for and who
// is fulfilling it. 
$transaction = new Transaction();
$transaction->setAmount($amount)
	->setItemList($itemList)
	->setDescription($description);

// ### Redirect urls
// Set the urls that the buyer must be redirected to after 
// payment approval/ cancellation.
$baseUrl = getBaseUrl();
$redirectUrls = new RedirectUrls();
$redirectUrls->setReturnUrl("$baseUrl/integrate-paypal-rest-api-php-mysql/execute.php?success=true")
	->setCancelUrl("$baseUrl/integrate-paypal-rest-api-php-mysql/execute.php?success=false");

// ### Payment
// A Payment Resource; create one using
// the above types and intent set to 'sale'
$payment = new Payment();
$payment->setIntent("sale")
	->setPayer($payer)
	->setRedirectUrls($redirectUrls)
	->setTransactions(array($transaction));

// ### Create Payment
// Create a payment by calling the 'create' method
// passing it a valid apiContext.
// (See bootstrap.php for more on `ApiContext`)
// The return object contains the state and the
// url to which the buyer must be redirected to
// for payment approval
try {
	$payment->create($apiContext);
} catch (PayPal\Exception\PPConnectionException $ex) {
	echo "Exception: " . $ex->getMessage() . PHP_EOL;
    echo "<pre>";
	var_dump($ex->getData());	
	exit(1);
}

// ### Get redirect url
// The API response provides the url that you must redirect
// the buyer to. Retrieve the url from the $payment->getLinks()
// method
foreach($payment->getLinks() as $link) {
	if($link->getRel() == 'approval_url') {
		$redirectUrl = $link->getHref();
		break;
	}
}
$payment_id = $payment->getId();

// ### Redirect buyer to PayPal website
// Save the payment id so that you can 'complete' the payment
// once the buyer approves the payment and is redirected
// back to your website.
//
// It is not a great idea to store the payment id
// in the session. In a real world app, you may want to 
// store the payment id in a database.

// to store product id and payment id in database
// for verification in execute.php verification
$_SESSION['paymentId'] = $payment_id;

    
    #### Store Payment ID in database ###
    //Create new table and store payment id againt product id in    
  
    //Open a new connection to the MySQL server
    $mysqli = new mysqli($strDBHost, $strDBUser, $strDBPass, $strDBName);
   
    //Output any connection error
    if ($mysqli->connect_error) {
        die('Error : (' . $mysqli->connect_errno . ') ' . $mysqli->connect_error);
    }      
   
    $payment_info = $mysqli->query("INSERT INTO paypal_payments (`product_id`, `payment_id`) VALUES ('" . $productid . "', '" . $payment_id . "')");
   
    if (!$payment_info) {
        die('Error : (' . $mysqli->errno . ') ' . $mysqli->error);
    }
    

if (isset($redirectUrl)) {
	header("Location: $redirectUrl");
	exit;
}

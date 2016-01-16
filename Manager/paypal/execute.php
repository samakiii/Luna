<?php
// #Execute Payment
// This  shows how you can complete
// a payment that has been approved by
// the buyer by logging into paypal site.
// You can optionally update transaction
// information by passing in one or more transactions.
// API used: POST '/v1/payments/payment/<payment-id>/execute'.

require __DIR__ . '/bootstrap.php';
require '../config.php';

use PayPal\Api\ExecutePayment;
use PayPal\Api\Payment;
use PayPal\Api\PaymentExecution;
session_start();
if (isset($_GET['success']) && $_GET['success'] == 'true') {
	
	
	// payment id was previously stored in session in
	// create.php
	$paymentId_session = $_SESSION['paymentId'];
    // if you used database to store product id and payment id
    // use below mysqli code to fetch payment_id from database
    


    #### GET PAYMENT ID ###
      
    //Open a new connection to the MySQL server
    $mysqli = new mysqli($strDBHost, $strDBUser, $strDBPass, $strDBName);
   
    //Output any connection error
    if ($mysqli->connect_error) {
        die('Error : (' . $mysqli->connect_errno . ') ' . $mysqli->connect_error);
    }      
   
    $payment_info = $mysqli->query("SELECT * FROM paypal_payments WHERE payment_id = '" . $mysqli->real_escape_string($paymentId_session) . "'");
   
    if ($payment_info->num_rows() > 0){
        $row = $payment_info->fetch_assoc();
        
        // Assign values fetched from database
        $productid = $row['product_id'];
        $paymentId = $row['payment_id'];


    } else {
        die('Error : (' . $mysqli->errno . ') ' . $mysqli->error);
    }
    
    if ($paymentId != $paymentId_session) {
        die("Payment id not verified");
        
        // only use below lines for testing, comment them in live website
        // echo "Payment id from session:" . $paymentId_session;
        // echo "Payment id from database:" . $paymentId ;
    }
   

    
    $paymentId = $paymentId_session;
    // Get the payment Object by passing paymentId
	$payment = Payment::get($paymentId, $apiContext);
	
	// PaymentExecution object includes information necessary 
	// to execute a PayPal account payment. 
	// The payer_id is added to the request query parameters
	// when the user is redirected from paypal back to your site
	$execution = new PaymentExecution();
	$execution->setPayerId($_GET['PayerID']);
	
	//Execute the payment
	// (See bootstrap.php for more on `ApiContext`)
	$result = $payment->execute($execution, $apiContext);

	echo "<pre>";
	var_dump($result);
	
	
} else {
	echo "User cancelled payment.";
}

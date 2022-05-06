import 'package:d_o_cakes/services/payhere_credentials.dart';

class PayHerePayment {
  Map paymentObjectOneTime = {
    "sandbox": true,
    // Replace your Merchant ID
    "merchant_id": PayHereAccountCredentials().merchantId,
    // See step 4e
    "merchant_secret": PayHereAccountCredentials().merchantSecret,
    "notify_url": "http://sample.com/notify",
    "order_id": "ItemNo12345",
    "items": "One Time Payment",
    "amount": "50.00",
    "currency": "LKR",
    "first_name": "",
    "last_name": "",
    "email": "",
    "phone": "",
    "address": "",
    "city": "",
    "country": "",
    "delivery_address": "",
    "delivery_city": "Kalutara",
    "delivery_country": "Sri Lanka",
    "custom_1": "",
    "custom_2": ""
  };
}

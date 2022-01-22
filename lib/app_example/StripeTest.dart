import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:myapp/services/PaymentServices.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // set the publishable key for Stripe - this is mandatory
//   Stripe.publishableKey =
//       "pk_test_51KA7XlGvchZjxCmYhvEqJbIhLO3AgP76rtm49FX8fXwpHLp3eCLrEDB7WsR8Fya2wstYxnLJw2s9X025FQoLtrPI00XPFFB6Mt";
//   runApp(PaymentScreen());
// }

// payment_screen.dart
class PaymentScreen extends StatelessWidget {
  PaymentScreen() {
    Stripe.publishableKey =
        "pk_test_51KA7XlGvchZjxCmYhvEqJbIhLO3AgP76rtm49FX8fXwpHLp3eCLrEDB7WsR8Fya2wstYxnLJw2s9X025FQoLtrPI00XPFFB6Mt";
  }
  CardFormEditController controller = new CardFormEditController();
  PaymentService service = new PaymentService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: 200,
            child: CardFormField(
              controller: controller,
              autofocus: true,
              onCardChanged: (data) {
                print(data);
              },
            ),
          ),
          TextButton(
            onPressed: () async {
              // create payment method
              var _stripe = Stripe.instance;
              try {
                final paymentMethod = await _stripe
                    .createPaymentMethod(PaymentMethodParams.card());
                print(paymentMethod);
                if (paymentMethod.id != null) {
                  service.linkCustomerWithPaymentMethod(
                      paymentMethod.id, context);
                }
              } on Exception catch (error) {
                print("Error occured");
                const snackBar = SnackBar(
                  content: Text('Invalid card details'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                print(error);
              } catch (error) {
                print("catching");
              }
            },
            child: Text('pay'),
          ),
        ],
      ),
    );
  }
}

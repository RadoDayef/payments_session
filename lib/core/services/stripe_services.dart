import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payments_session/core/constants/stripe_constants.dart';

class StripeServices {
  StripeServices._();

  static final StripeServices instance = StripeServices._();

  Future<void> init() async {
    Stripe.publishableKey = StripeConstants.publishableKey;
    await Stripe.instance.applySettings();
  }

  Future<void> showPaymentSheet(String intentSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(paymentIntentClientSecret: intentSecret, merchantDisplayName: "Payments Session"),
    );
    await Stripe.instance.presentPaymentSheet();
  }
}

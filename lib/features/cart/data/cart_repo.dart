import 'dart:convert';

import 'package:http/http.dart';
import 'package:payments_session/core/constants/stripe_constants.dart';
import 'package:payments_session/core/networking/api_result.dart';

class CartRepo {
  Future<ApiResult<String>> createPaymentIntent(int amount) async {
    try {
      Client client = Client();
      Response response = await client.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: {"amount": amount.toString(), "currency": "usd"},
        headers: {"Authorization": "Bearer ${StripeConstants.secretKey}"},
      );
      final intentSecret = jsonDecode(response.body);
      return ApiSuccess(intentSecret["client_secret"]);
    } catch (exception) {
      return ApiFailure(exception.toString());
    }
  }
}

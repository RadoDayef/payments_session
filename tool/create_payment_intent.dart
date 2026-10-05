// ============================================================================
// INSTRUCTOR TOOL — not part of the Flutter app.
//
// This is a throwaway script that runs on YOUR computer to create a demo
// PaymentIntent and print its client secret, so you have something real to
// paste into lib/stripe_service.dart before class.
//
// It is deliberately NOT in lib/, so it is never compiled into the app.
// It uses no packages — only dart:io, which is part of plain Dart.
//
// HOW TO RUN:
//   dart run tool/create_payment_intent.dart sk_test_XXXXXXXXXXXXXXXX
//
// Or keep the key out of your shell history:
//   export STRIPE_SECRET_KEY=sk_test_XXXXXXXXXXXXXXXX
//   dart run tool/create_payment_intent.dart
//
// ⚠️ The sk_test_ secret key is used HERE, on your machine only.
//    It is never written into lib/ and never shipped to students' devices.
// ============================================================================

import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  // The secret key. Passed as an argument or an env var — never hardcoded.
  final secretKey = args.isNotEmpty
      ? args.first
      : Platform.environment['STRIPE_SECRET_KEY'] ?? '';

  if (!secretKey.startsWith('sk_test_')) {
    stderr.writeln('ERROR: pass a TEST secret key (sk_test_...), not a live key.');
    stderr.writeln('Usage: dart run tool/create_payment_intent.dart sk_test_XXX');
    exitCode = 1;
    return;
  }

  // Build the form body Stripe expects.
  // amount is in CENTS: 2000 = $20.00
  final body = <String, String>{
    'amount': '2000',
    'currency': 'usd',
    // Card only — keeps the classroom Payment Sheet simple and predictable.
    'payment_method_types[]': 'card',
    'description': 'Flutter Course (classroom demo)',
  }.entries
      .map((e) => '${e.key}=${Uri.encodeQueryComponent(e.value)}')
      .join('&');

  final client = HttpClient();
  final request = await client.postUrl(
    Uri.parse('https://api.stripe.com/v1/payment_intents'),
  );

  // Stripe API auth: the key as HTTP Basic username, empty password.
  final basic = base64Encode(utf8.encode('$secretKey:'));
  request.headers.set(HttpHeaders.authorizationHeader, 'Basic $basic');
  request.headers.contentType = ContentType('application', 'x-www-form-urlencoded');
  request.write(body);

  final response = await request.close();
  final text = await response.transform(utf8.decoder).join();

  if (response.statusCode != 200) {
    stderr.writeln('Stripe returned ${response.statusCode}:');
    stderr.writeln(text);
    exitCode = 1;
    return;
  }

  final json = jsonDecode(text) as Map<String, String>;

  stdout.writeln('PaymentIntent created.');
  stdout.writeln('');
  stdout.writeln('id:           ${json['id']}');
  stdout.writeln('');
  stdout.writeln('👉 Paste this into lib/stripe_service.dart, replacing the');
  stdout.writeln('   demoPaymentIntentClientSecret placeholder:');
  stdout.writeln('');
  stdout.writeln(json['client_secret']);
  stdout.writeln('');
  stdout.writeln('Note: one PaymentIntent = one successful payment.');
  stdout.writeln('Generate a new one before each demo run.');
}
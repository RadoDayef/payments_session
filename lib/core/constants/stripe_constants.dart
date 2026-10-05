/// Stripe keys are injected at build time so they never land in the repo.
///
/// Pass them on the command line:
///
/// ```
/// flutter run \
///   --dart-define=STRIPE_PUBLISHABLE_KEY=pk_test_... \
///   --dart-define=STRIPE_SECRET_KEY=sk_test_...
/// ```
class StripeConstants {
  StripeConstants._();

  static const String publishableKey =
      String.fromEnvironment('STRIPE_PUBLISHABLE_KEY');

  static const String secretKey =
      String.fromEnvironment('STRIPE_SECRET_KEY');
}
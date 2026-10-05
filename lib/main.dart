import 'package:flutter/material.dart';
import 'package:payments_session/app/my_app.dart';
import 'package:payments_session/core/services/stripe_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StripeServices.instance.init();
  runApp(MyApp());
}

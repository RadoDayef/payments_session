import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payments_session/features/cart/data/cart_repo.dart';
import 'package:payments_session/features/cart/logic/cart_cubit.dart';
import 'package:payments_session/features/cart/ui/cart_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(create: (context) => CartCubit(CartRepo()), child: CartScreen()),
    );
  }
}

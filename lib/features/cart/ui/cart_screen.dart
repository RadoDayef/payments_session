import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payments_session/features/cart/data/models/course_model.dart';
import 'package:payments_session/features/cart/logic/cart_cubit.dart';
import 'package:payments_session/features/cart/ui/widgets/course_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<CourseModel> courses = [
      CourseModel(price: 200, title: "Flutter Diploma", subtitle: "Mobile App Development"),
      CourseModel(price: 250, title: "Android Diploma", subtitle: "Mobile App Development"),
      CourseModel(price: 100, title: "React-Native Diploma", subtitle: "Mobile App Development"),
    ];

    int getTotal() {
      int total = 0;
      for (CourseModel course in courses) {
        total += course.price;
      }
      return total;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text("My Cart", style: TextStyle(fontWeight: .bold)),
      ),
      body: SafeArea(
        child: Padding(
          padding: .all(24),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(itemCount: courses.length, separatorBuilder: (_, _) => SizedBox(height: 16), itemBuilder: (_, index) => CourseWidget(courses[index])),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text("Total", style: TextStyle(fontWeight: .bold, fontSize: 18)),
                  Text("\$${getTotal()}", style: TextStyle(fontWeight: .bold, fontSize: 18)),
                ],
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 50,
                width: .infinity,
                child: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is CartLoading ? null : () => context.read<CartCubit>().pay(getTotal()),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                      child: state is CartLoading ? CircularProgressIndicator(color: Colors.black) : Text("Pay \$${getTotal()}", style: TextStyle(fontSize: 20, fontWeight: .bold)),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

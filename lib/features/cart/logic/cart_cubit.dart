import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payments_session/core/networking/api_result.dart';
import 'package:payments_session/core/services/stripe_services.dart';
import 'package:payments_session/features/cart/data/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo _repo;

  CartCubit(this._repo) : super(CartInitial());

  void pay(int amount) async {
    emit(CartLoading());
    final ApiResult<String> intentSecretResult = await _repo.createPaymentIntent(amount * 100);
    if (intentSecretResult is ApiSuccess<String>) {
      await StripeServices.instance.showPaymentSheet(intentSecretResult.data);
      emit(CartSuccess());
    } else {
      emit(CartFailure((intentSecretResult as ApiFailure).message));
    }
  }
}

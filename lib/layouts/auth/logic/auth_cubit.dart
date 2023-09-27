import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  int loginFormState = 0;
  bool isLoading = false;
  bool isHidden = true;

  static AuthCubit get(context) => BlocProvider.of(context);
  void loginPageState(index) {
    loginFormState = index;
    emit(LoginPageUpdate());
  }

  void buttonIsLoading(bool buttonIsLoading) {
    isLoading = buttonIsLoading;
    emit(ButtonLoadingState());
  }

  void passwordState() {
    isHidden = !isHidden;
    emit(PasswordState());
  }
}

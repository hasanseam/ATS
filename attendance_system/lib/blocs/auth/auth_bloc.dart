import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    // Handle login event
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      // Simulated delay for login process
      await Future.delayed(Duration(seconds: 2));

      // Example login logic
      if (true) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthError("Invalid username or password"));
      }
    });

    // Handle logout event
    on<LogoutRequested>((event, emit) {
      emit(AuthInitial()); // Emit initial state to reset to logged-out state
    });
  }
}

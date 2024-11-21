import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/api_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ApiService apiService;
  AuthBloc({required  this.apiService}) : super(AuthInitial()) {
    // Handle login event
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading()); // Emit loading state while logging in

      try {
        print("Hello");
        final tokens = await apiService.login(event.username, event.password);
        final accessToken = tokens['accessToken']!;
        final refreshToken = tokens['refreshToken']!;
        // Save tokens securely (e.g., using SharedPreferences or SecureStorage)
        emit(AuthAuthenticated()); // Emit authenticated state with tokens
      } catch (e) {
        emit(AuthError("Authentication failed: $e"));  // Emit error if login fails
      }
    });

    // Handle logout event
    on<LogoutRequested>((event, emit) {
      emit(AuthInitial()); // Emit initial state to reset to logged-out state
    });
  }
}

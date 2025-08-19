import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      // for login page :-
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          // ignore: unused_local_variable
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: event.email,
                password: event.password,
              );
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          // طباعة الخطأ في الكونسول لمعرفة الكود الفعلي
          print("Error Code: ${e.code}");
          print("Error Message: ${e.message}");

          String errorMessage = "An unexpected error occurred.";

          // التحقق من كود الخطأ وإظهار الرسالة المناسبة
          if (e.code == 'user-not-found') {
            errorMessage = "No user found for that email.";
          } else if (e.code == 'wrong-password') {
            errorMessage = "Wrong password provided for that user.";
          } else if (e.code == 'invalid-credential') {
            errorMessage = "Invalid email or password.";
          } else if (e.code == 'invalid-email') {
            errorMessage = "Invalid email format.";
          } else if (e.code == 'user-disabled') {
            errorMessage = "This account has been disabled.";
          } else if (e.code == 'too-many-requests') {
            errorMessage = "Too many attempts. Try again later.";
          }
          emit(LoginFailure(errorMessage: errorMessage));
        } catch (e) {
          emit(
            LoginFailure(
              errorMessage: "Something went wrong. Please try again.",
            ),
          );
        }
      }
      // for register page :-
      else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          // ignore: unused_local_variable
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: event.email,
                password: event.password,
              );
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(RegisterFailure(errorMessage: "weak password"));
          } else if (ex.code == 'email-already-in-use') {
            emit(RegisterFailure(errorMessage: "email already exists"));
          }
        } catch (e) {
          emit(RegisterFailure(errorMessage: "there was an error try again"));
        }
      }
    });
  }
}

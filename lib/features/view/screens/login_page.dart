
import 'package:chat_app_1/constants.dart';
import 'package:chat_app_1/core/helper/show_snack_bar.dart';
import 'package:chat_app_1/features/view_model/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app_1/features/view/screens/resgister_page.dart';
import 'package:chat_app_1/features/view/widgets/custom_button.dart';
import 'package:chat_app_1/features/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_page.dart';

class LoginPage extends StatelessWidget {
  static String id = 'login page';

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamed(context, ChatPage.id, arguments: email.text);
        } else if (state is LoginFailure) {
          showSnackBar(context, state.errorMessage);
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: state is LoginLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), 
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  SizedBox(height: screenHeight * 0.1), 
                  Image.asset(
                    'assets/images/scholar.png',
                    height: screenHeight * 0.15, 
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Scholar Chat',
                        style: TextStyle(
                          fontSize: screenWidth * 0.08, 
                          color: Colors.white,
                          fontFamily: 'pacifico',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.08), 
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: screenWidth * 0.055, 
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03), 
                  CustomFormTextField(controller: email, hintText: 'Email'),
                  SizedBox(height: screenHeight * 0.015), 
                  CustomFormTextField(
                    controller: password,
                    obscureText: true,
                    hintText: 'Password',
                  ),
                  SizedBox(height: screenHeight * 0.03), 
                  CustomButon(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(
                          LoginEvent(
                            email: email.text,
                            password: password.text,
                          ),
                        );
                      }
                    },
                    text: 'LOGIN',
                  ),
                  SizedBox(height: screenHeight * 0.02), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'don\'t have an account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegisterPage.id);
                        },
                        child: Text(
                          '  Register',
                          style: TextStyle(
                            color: const Color(0xffC7EDE6),
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

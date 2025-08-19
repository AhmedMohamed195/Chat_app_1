import 'package:chat_app_1/constants.dart';
import 'package:chat_app_1/features/view_model/blocs/chat_bloc/chat_bloc.dart';
import 'package:chat_app_1/features/view/screens/login_page.dart';
import 'package:chat_app_1/features/view/widgets/chat_buble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final _controller = ScrollController();
  final TextEditingController controller = TextEditingController();

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.height;
    final String? email = ModalRoute.of(context)?.settings.arguments as String?;
    // بدء تحميل الرسائل مباشرة
    BlocProvider.of<ChatBloc>(context).add(GetMessage());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              final navigator = Navigator.of(context); 
              await FirebaseAuth.instance.signOut();
              navigator.pushNamed(LoginPage.id);
            },
            icon: Icon(Icons.exit_to_app),
            color: Colors.black,
          ),
        ],
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(kLogo, height: screenHeight * 0.065),
              const Text('chat'),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatSuccess) {
                  var chatMessages = state.messages;
                  return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index) {
                      return chatMessages[index].id == email
                          ? ChatBuble(message: chatMessages[index])
                          : ChatBubleForFriend(message: chatMessages[index]);
                    },
                  );
                } else {
                  return const Center(child: Text("No messages yet."));
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                if (email != null) {
                  BlocProvider.of<ChatBloc>(
                    context,
                  ).add(SendMessage(message: data, email: email));
                }
                controller.clear();
                _controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: const Icon(Icons.send, color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

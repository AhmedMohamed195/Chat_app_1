import 'package:bloc/bloc.dart';
import 'package:chat_app_1/constants.dart';
import 'package:chat_app_1/features/data/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      CollectionReference messages = FirebaseFirestore.instance.collection(
        kMessagesCollections,
      );
      if (event is SendMessage) {
        messages.add({
          kMessage: event.message,
          kCreatedAt: DateTime.now(),
          'id': event.email,
        });
      }
      else if (event is GetMessage) {
        await emit.forEach<QuerySnapshot>(
          messages.orderBy(kCreatedAt, descending: true).snapshots(),
          onData: (snapshot) {
            List<Message> messagesList = [];
            for (var doc in snapshot.docs) {
              messagesList.add(Message.fromJson(doc));
            }
            return ChatSuccess(messages: messagesList);
          },
        );
      }
    });
  }
}

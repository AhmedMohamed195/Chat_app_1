part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class SendMessage extends ChatEvent {
  final String message;
  final String email;
  SendMessage({required this.message, required this.email});
}

class GetMessage extends ChatEvent {}

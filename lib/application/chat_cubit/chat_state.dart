part of 'chat_cubit.dart';

class ChatState {
  ListOfChat chatList = [];
  bool isTyping;
  int dailyLimit;
  int extraLimit;

  ChatState(
      {this.chatList,
      this.isTyping = false,
      this.dailyLimit = 0,
      this.extraLimit = 0});

  ChatState copyWith({
    ListOfChat chatList,
    bool? isTyping,
    int? dailyLimit,
    int? extraLimit,
  }) {
    return ChatState(
      chatList: chatList ?? this.chatList,
      isTyping: isTyping ?? this.isTyping,
      dailyLimit: dailyLimit ?? this.dailyLimit,
      extraLimit: extraLimit ?? this.extraLimit,
    );
  }
}

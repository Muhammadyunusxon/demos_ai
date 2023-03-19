import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demos_ai/infrastructure/services/app_errors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../infrastructure/models/chat_model.dart';
import '../../infrastructure/services/api_service.dart';
import '../../infrastructure/services/local_storage.dart';
import '../../presentation/utils/style/style.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState());

  getLimit() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    var res = await firestore
        .collection("users")
        .doc(await LocalStore.getDocId())
        .get();
    emit(state.copyWith(
        extraLimit: res.data()?["extraLimit"],
        dailyLimit: res.data()?["dailyLimit"]));
  }

  addUserMessage({required String msg}) {
    ListOfChat chatList = [];
    if (state.chatList != null) {
      chatList.addAll(state.chatList!);
    }

    chatList.add(ChatModel(msg: msg, chatIndex: 0));
    emit(state.copyWith(chatList: chatList));
  }

  sendMessageAndGetAnswers({required String msg}) async {
    ListOfChat chatList = [];
    if (state.chatList != null) {
      chatList.addAll(state.chatList!);
    }
    chatList.addAll(await ApiService.sendMessageGPT(message: msg));
    emit(state.copyWith(chatList: chatList));
  }

  Future<void> sendMessageFCT(
      {required String msg,
      required BuildContext context,
      required VoidCallback onSummit,
      required VoidCallback onFinal}) async {
    if (state.dailyLimit == 0 && state.extraLimit == 0) {
      showTopSnackBar(Overlay.of(context),
          const CustomSnackBar.error(message: AppErrors.limit));
      return;
    }
    if (state.isTyping) {
      showTopSnackBar(Overlay.of(context),
          const CustomSnackBar.error(message: AppErrors.multipleMessage));
      return;
    }

    if (msg.isEmpty) {
      showTopSnackBar(Overlay.of(context),
          const CustomSnackBar.error(message: AppErrors.emptyMessage));
      return;
    }
    try {
      emit(state.copyWith(isTyping: true));
      addUserMessage(msg: msg);
      onSummit();
      await sendMessageAndGetAnswers(msg: msg);
    } catch (error) {
      log("error $error");
      showTopSnackBar(
          Overlay.of(context), CustomSnackBar.error(message: error.toString()));
      return;
    } finally {
      changeLimit();
      emit(state.copyWith(isTyping: false));
      onFinal();
    }
  }

  changeLimit() async {
    if (state.dailyLimit == 0) {
      emit(state.copyWith(extraLimit: state.extraLimit - 1));
    } else {
      emit(state.copyWith(dailyLimit: state.dailyLimit - 1));
    }
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection("users")
        .doc(await LocalStore.getDocId())
        .update({
      "dailyLimit": state.dailyLimit,
      "extraLimit": state.extraLimit,
    });
  }
}

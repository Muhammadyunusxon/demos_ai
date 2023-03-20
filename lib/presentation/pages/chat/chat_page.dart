import 'package:demos_ai/application/chat_cubit/chat_cubit.dart';
import 'package:demos_ai/presentation/pages/chat/widget/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../infrastructure/services/assets_manager.dart';
import '../../utils/style/style.dart';

class ChatPage extends StatefulWidget {
  final VoidCallback onExit;
  const ChatPage({Key? key,required this.onExit}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        widget.onExit();
        return Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset(AssetsManager.logo),
          ),
          title: Text(
            "Demos chat",
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                        controller: _listScrollController,
                        itemCount: state.chatList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return ChatWidget(
                            msg: state.chatList?[index].msg ?? " ",
                            // chatList[index].msg,
                            chatIndex: state.chatList?[index].chatIndex ?? 0,
                            //chatList[index].chatIndex,
                            shouldAnimate:
                                (state.chatList?.length ?? 1) - 1 == index,
                          );
                        }),
                  ),
                  if (state.isTyping) ...[
                    const SpinKitThreeBounce(
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                  const SizedBox(height: 15),
                  Material(
                    color: Style.cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              focusNode: focusNode,
                              style: const TextStyle(color: Colors.white),
                              controller: textEditingController,
                              onSubmitted: (value) async {
                                context.read<ChatCubit>().sendMessageFCT(
                                    msg: textEditingController.text,
                                    context: context,
                                    onSummit: () {
                                      textEditingController.clear();
                                      focusNode.unfocus();
                                    },
                                    onFinal: () {
                                      scrollListToEND();
                                    });
                              },
                              decoration: const InputDecoration.collapsed(
                                  hintText: "How can I help you",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                                await context.read<ChatCubit>().sendMessageFCT(
                                    msg: textEditingController.text,
                                    context: context,
                                    onSummit: () {
                                      textEditingController.clear();
                                      focusNode.unfocus();
                                    },
                                    onFinal: () {
                                      scrollListToEND();
                                    });
                              },
                              icon: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }
}

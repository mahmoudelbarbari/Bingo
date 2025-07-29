import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_app_bar_widget.dart';
import 'package:bingo/core/widgets/custome_textfield_widget.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/injection_container.dart';
import '../../domain/entity/chat_message.dart';
import '../cubit/chat_bot_cubit.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  late final TextEditingController addCommentcontroller;

  @override
  void initState() {
    addCommentcontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    addCommentcontroller.dispose();
    super.dispose();
  }

  // late final stt.SpeechToText _speech = stt.SpeechToText();

  // Future<void> _startListening() async {
  //   final status = await Permission.microphone.request();
  //   if (status.isGranted) {
  //     bool available = await _speech.initialize();
  //     if (available) {
  //       _speech.listen(
  //         onResult: (result) {
  //           setState(() {
  //             addCommentcontroller.text = result.recognizedWords;
  //           });
  //         },
  //       );
  //     }
  //   } else {
  //     // ScaffoldMessenger.of(
  //     //   context,
  //     // ).showSnackBar(SnackBar(content: Text('Microphone permission denied')));
  //     showAppSnackBar(
  //       context,
  //       AppLocalizations.of(context)!.microphonePermissionDenied,
  //       isError: true,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return BlocProvider(
      create: (context) => ChatCubit(sl()),
      child: Scaffold(
        appBar: CustomeAppBarWidget(
          title: loc.bingoChatBot,
          subTitle: loc.official,
          textStyle: Theme.of(context).textTheme.titleMedium,
        ),
        body: Form(
          child: Column(
            children: [
              _listMessageWidget(),
              GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 24.h,
                  ),
                  child: CustomeTextfieldWidget(
                    controller: addCommentcontroller,
                    isRTL: isArabic,
                    hintlText: '${loc.sendMessage}...',
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.keyboard_voice_outlined),
                        ),
                        IconButton(
                          onPressed: () {
                            final text = addCommentcontroller.text.trim();
                            if (text.isNotEmpty) {
                              context.read<ChatCubit>().sendMessage(text);
                              addCommentcontroller.clear();
                            }
                          },
                          icon: Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _listMessageWidget() {
  return Expanded(
    child: BlocBuilder<ChatCubit, List<ChatMessage>>(
      builder: (context, messages) {
        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final msg = messages[messages.length - 1 - index];
            return Align(
              alignment: msg.isFromUser
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: msg.isFromUser ? Colors.blue[200] : Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(msg.message),
              ),
            );
          },
        );
      },
    ),
  );
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:richer_text/richer_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyWidget());
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Richer Text Example'),
      ),
      body: Center(
          child: Column(
        children: [
          // RicherText without catcher
          const RicherText(text: 'Hello World'),
          // RicherText with catcher
          RicherText(
            text: 'Hello World',
            catchers: [
              RicherTextCatcher(
                name: 'catch_test',
                pattern: RegExp(r'Hello'),
                builder: (text) => TextSpan(
                    text: text, style: const TextStyle(color: Colors.red)),
              ),
            ],
          ),
          // RicherText with urlCatcher
          RicherText(
            text: 'Hello World https://flutter.dev',
            catchers: [RicherTextCatchers.urlCatcher()],
          ),

          // RicherText with urlCatcher with tap action
          RicherText(
            text: 'Click this -> https://flutter.dev',
            catchers: [
              RicherTextCatchers.urlCatcher(
                  builder: (text) => TextSpan(
                        text: text,
                        style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => ScaffoldMessenger.of(context)
                              .showSnackBar(
                                  SnackBar(content: Text('You tapped $text'))),
                      ))
            ],
          ),

          // RicherText with emailCatcher
          RicherText(
            text: 'Hello World test@test.com.tr',
            catchers: [RicherTextCatchers.emailCatcher()],
          ),

          // RicherText with userCatcher
          RicherText(
            text: 'Hello World @Ensar',
            catchers: [RicherTextCatchers.userCatcher()],
          ),

          // RicherText with hashtagCatcher
          RicherText(
            text: 'Hello World #Flutter',
            catchers: [RicherTextCatchers.hashtagCatcher()],
          ),

          // RicherText catcher with multiple patterns
          RicherText(
            text:
                'Hello World and Hello #Flutter. My name is @Ensar and my dummy email is test@test.com',
            catchers: [
              RicherTextCatcher(
                  name: 'helloworld',
                  pattern: RegExp(r'Hello World'),
                  builder: (text) => TextSpan(
                      text: text,
                      style: const TextStyle(color: Colors.purple))),
              RicherTextCatcher(
                name: 'hello',
                pattern: RegExp(r'Hello'),
                builder: (text) => TextSpan(
                    text: text, style: const TextStyle(color: Colors.red)),
              ),
              RicherTextCatchers.emailCatcher(),
              RicherTextCatchers.hashtagCatcher(),
              RicherTextCatchers.userCatcher(),
            ],
          ),

          // RicherText catcher with multiple patterns and ignored pattern
          RicherText(
            text:
                'Hello World and Hello #Flutter. My name is @Ensar and my dummy email is test@test.com',
            catchers: [
              RicherTextCatcher(
                name: 'hello',
                pattern: RegExp(r'Hello'),
                builder: (text) => TextSpan(
                    text: text, style: const TextStyle(color: Colors.red)),
              ),
              RicherTextCatcher(
                  name: 'helloworld',
                  pattern: RegExp(r'Hello World'),
                  builder: (text) => TextSpan(
                      text: text,
                      style: const TextStyle(color: Colors.purple))),
              RicherTextCatchers.emailCatcher(),
              RicherTextCatchers.hashtagCatcher(),
              RicherTextCatchers.userCatcher(),
            ],
          ),
        ],
      )),
    );
  }
}

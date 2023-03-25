import 'package:flutter/material.dart';
import './richer_text_catcher.dart';

/// Class that defines frequently used [RicherTextCatcher]s.
class RicherTextCatchers {
  /// [RicherTextCatcher] that matches urls.
  static RicherTextCatcher urlCatcher({
    String? name,
    TextSpan Function(String text)? builder,
    int? priority,
  }) {
    return RicherTextCatcher(
      name: name ?? 'url',
      pattern: RegExp(
          r'((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?'),
      builder: builder ??
          (text) => TextSpan(
                text: text,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
      priority: priority ?? 0,
    );
  }

  /// [RicherTextCatcher] that matches emails.
  static RicherTextCatcher emailCatcher({
    String? name,
    TextSpan Function(String text)? builder,
    int? priority,
  }) {
    return RicherTextCatcher(
      name: name ?? 'email',
      pattern: RegExp(r'([a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+)'),
      builder: builder ??
          (text) => TextSpan(
                text: text,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
      priority: priority ?? 0,
    );
  }

  /// [RicherTextCatcher] that tags users.
  /// Note: This is just an example. Please create your own [RicherTextCatcher]
  /// for your use case.
  static RicherTextCatcher userCatcher({
    String? name,
    TextSpan Function(String text)? builder,
    int? priority,
  }) {
    return RicherTextCatcher(
      name: name ?? 'user',
      pattern: RegExp(r'\B@([\S]+)'),
      builder: builder ??
          (text) => TextSpan(
                text: text,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
      priority: priority ?? 0,
    );
  }

  /// [RicherTextCatcher] that tags hashtags.
  /// Note: This is just an example. Please create your own [RicherTextCatcher]
  /// for your use case.

  static RicherTextCatcher hashtagCatcher({
    String? name,
    TextSpan Function(String text)? builder,
    int? priority,
  }) {
    return RicherTextCatcher(
      name: name ?? 'hashtag',
      pattern: RegExp(r'\B#([\S]+)'),
      builder: builder ??
          (text) => TextSpan(
                text: text,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
      priority: priority ?? 0,
    );
  }
}

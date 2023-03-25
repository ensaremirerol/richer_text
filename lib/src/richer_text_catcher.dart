import 'package:flutter/widgets.dart';
import 'package:richer_text/src/richer_text.dart';

/// A class that defines a pattern to be matched and a builder to be used to
/// build the [TextSpan] for the matched text.
/// Arguments:
///  * [name]: The name of the pattern.
///  * [pattern]: The pattern to be matched.
///  * [builder]: The builder to be used to build the [TextSpan] for the matched text.
///  * [priority]: The priority of the pattern. The higher the priority, the earlier the pattern will be matched.
///   Defaults to 0. If two patterns have the same priority, order of listing in the [RicherText] widget will be used.

class RicherTextCatcher {
  /// The name of the pattern.
  final String name;

  /// The pattern to be matched.
  final Pattern pattern;

  /// The priority of the pattern. The higher the priority, the earlier the pattern will be matched.
  /// Only zero or positive integers are allowed.
  /// Default is 0. If two patterns have the same priority, order of listing in the [RicherText] widget will be used.
  final int priority;

  /// The builder to be used to build the [TextSpan] for the matched text.
  final TextSpan Function(String text)? builder;

  /// Creates a [RicherTextCatcher] with the given [name], [pattern] and [builder].
  ///
  /// If [builder] is not provided, the default builder will be used.
  ///
  /// If [priority] is not provided, it will default to 0, which is the highest priority.
  const RicherTextCatcher({
    required this.name,
    required this.pattern,
    required this.builder,
    this.priority = 0,
  }) : assert(priority >= 0, 'Priority must be zero or positive');

  /// Returns a list of [Match] objects that contain the results of matching
  List<Match> match(String text) => pattern.allMatches(text).toList();

  RicherTextCatcher copyWith({
    String? name,
    Pattern? pattern,
    TextSpan Function(String text)? builder,
    int? priority,
  }) =>
      RicherTextCatcher(
        name: name ?? this.name,
        pattern: pattern ?? this.pattern,
        builder: builder ?? this.builder,
        priority: priority ?? this.priority,
      );
}

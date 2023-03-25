import 'package:flutter/rendering.dart';

/// A class that defines a span of text that is matched by a pattern.
///
/// Arguments:
/// * [start]: The start index of the span.
/// * [end]: The end index of the span.
/// * [builder]: The builder to be used to build the [TextSpan] for the matched text.

class Span {
  /// The start index of the span.
  final int start;

  /// The end index of the span.
  final int end;

  /// The builder to be used to build the [TextSpan] for the matched text.
  final TextSpan Function(String text)? builder;

  /// Creates a [Span] with the given [start] and [end] indices and [builder].
  /// If [builder] is not provided, the default builder will be used.
  Span({
    required this.start,
    required this.end,
    required this.builder,
  }) : assert(start < end);

  /// Creates a [Span] with the given [start] and [end] indices.
  /// It is used to create a span that is not matched by any pattern.
  Span.defaultBuilder({required this.start, required this.end})
      : builder = null,
        assert(start < end);
  /// Returns true if the span overlaps with the given [other] span.
  bool collidesWith(Span other) {
    return start < other.end && end > other.start;
  }

  /// Returns true if the span includes the given [index].
  bool includes(int index) {
    return index >= start && index < end;
  }

  /// Returns true if the span is matched by a pattern.
  int compareTo(Span other) {
    return start.compareTo(other.start);
  }
}

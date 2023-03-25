import 'package:flutter/material.dart';
import './richer_text_catcher.dart';
import './richer_text_span.dart';

/// Creates a [RichText] or [SelectableText] widget with the given [text] and [catchers].
/// 
/// The [catchers] are used to match patterns in the [text] and build the [TextSpan]s for the matched text.
/// 
/// The [catchers] are sorted by their [RicherTextCatcher.priority] and higher priority [catchers] are used to find matches first.
/// 
/// So, if two [RicherTextCatcher]s match the same text, the one with the higher priority will be used.
/// 
/// If two [catchers] have the same [RicherTextCatcher.priority], the order of listing in the [catchers] list will be used.
/// 
/// If no [catchers] are provided, the [defaultBuilder] will be used to build the [TextSpan] for the [text].
/// 
/// If no [defaultBuilder] is provided, the default style of the [RichText] or [SelectableText] widget will be used.
class RicherText extends StatelessWidget {
  /// Creates a [RicherText] widget with the given [text] and [catchers].
  /// 
  /// Arguments:
  /// 
  /// * [key]: The key of the widget.
  /// 
  /// * [text]: The text to be displayed.
  /// 
  /// * [selectable]: Whether the text should be selectable or not.
  /// 
  /// * [catchers]: The list of [RicherTextCatcher]s to be used to match patterns in the [text] and build the [TextSpan]s for the matched text.
  /// 
  /// * [defaultBuilder]: The builder to be used to build the [TextSpan] for the [text] if no [catchers] are provided.
  /// If no [defaultBuilder] is provided, the [TextSpan] widget will be used as the default builder.
  /// 
  const RicherText(
      {super.key,
      required this.text,
      this.selectable = false,
      this.catchers = const [],
      this.defaultBuilder});

  final String text;
  final bool selectable;
  final TextSpan Function(String text)? defaultBuilder;
  final List<RicherTextCatcher> catchers;

  @override
  Widget build(BuildContext context) {
    if (selectable) {
      return _buildSelectableText();
    } else {
      return _buildRichText();
    }
  }

  Text _buildRichText() {
    return Text.rich(
      TextSpan(children: [
        ..._buildTextSpans(text),
      ]),
    );
  }
  
  SelectableText _buildSelectableText() {
    return SelectableText.rich(
      TextSpan(children: [
        ..._buildTextSpans(text),
      ]),
    );
  }


  /// Builds the [TextSpan]s for the [text] using the [catchers] and [defaultBuilder].
  List<InlineSpan> _buildTextSpans(String text) {
    if (catchers.isEmpty) {
      return [
        defaultBuilder?.call(text) ?? TextSpan(text: text),
      ];
    }

    final catcherList = List<RicherTextCatcher>.from(catchers);

    final List<Span> spans = [];

    catcherList.sort((a, b) => b.priority.compareTo(a.priority));

    for (final pattern in catcherList) {
      final potentialSpans = pattern
          .match(text)
          .map(
              (e) => Span(start: e.start, end: e.end, builder: pattern.builder))
          .toList();
      final notCollidingSpans = potentialSpans
          .where((e) => !spans.any((span) => span.collidesWith(e)))
          .toList();
      spans.addAll(notCollidingSpans);
    }

    if (spans.isEmpty) {
      return [
        defaultBuilder?.call(text) ?? TextSpan(text: text),
      ];
    }

    spans.sort((a, b) => a.compareTo(b));

    int lastEnd = 0;

    final List<Span> result = [];

    for (final span in spans) {
      if (span.start > lastEnd) {
        result.add(Span.defaultBuilder(
          start: lastEnd,
          end: span.start,
        ));
      }
      result.add(span);
      lastEnd = span.end;
    }

    if (lastEnd < text.length) {
      result.add(Span.defaultBuilder(
        start: lastEnd,
        end: text.length,
      ));
    }

    return result
        .map((e) =>
            e.builder?.call(text.substring(e.start, e.end)) ??
            defaultBuilder?.call(text.substring(e.start, e.end)) ??
            TextSpan(text: text.substring(e.start, e.end)))
        .toList();
  }
}

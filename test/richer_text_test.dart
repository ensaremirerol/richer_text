import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:richer_text/richer_text.dart';

void main() {
  testWidgets('Create RicherText without catchers',
      (WidgetTester tester) async {
    const text = 'Hello World';
    await tester.pumpWidget(
      const _TestWidget(
        richerText: RicherText(
          text: text,
        ),
      ),
    );
    expect(find.text(text), findsOneWidget);
    await expectLater(
      find.byType(_TestWidget),
      matchesGoldenFile(
        'golden/richer_text.png',
      ),
    );
  });

  testWidgets('Create RicherText with catchers', (WidgetTester tester) async {
    const text = 'Hello World';
    await tester.pumpWidget(
      _TestWidget(
        richerText: RicherText(
          text: text,
          defaultBuilder: (text) => TextSpan(text: text),
          catchers: [
            RicherTextCatcher(
              name: 'catch_test',
              pattern: RegExp(r'Hello'),
              builder: (text) => TextSpan(
                  text: text, style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
    expect(find.text(text), findsOneWidget);
    await expectLater(
      find.byType(_TestWidget),
      matchesGoldenFile(
        'golden/richer_text_catcher.png',
      ),
    );
  });

  testWidgets('Create RicherText with urlCatcher', (WidgetTester tester) async {
    const text = 'Hello World https://flutter.dev';
    await tester.pumpWidget(
      _TestWidget(
        richerText: RicherText(
          text: text,
          defaultBuilder: (text) => TextSpan(text: text),
          catchers: [RicherTextCatchers.urlCatcher()],
        ),
      ),
    );

    expect(find.text(text), findsOneWidget);
    await expectLater(
      find.byType(_TestWidget),
      matchesGoldenFile(
        'golden/richer_text_url_catcher.png',
      ),
    );
  });

  testWidgets('Create RicherText with emailCatcher',
      (WidgetTester tester) async {
    const text = 'Hello World test@test.com.tr';
    await tester.pumpWidget(
      _TestWidget(
        richerText: RicherText(
          text: text,
          defaultBuilder: (text) => TextSpan(text: text),
          catchers: [RicherTextCatchers.emailCatcher()],
        ),
      ),
    );

    expect(find.text(text), findsOneWidget);

    await expectLater(
      find.byType(_TestWidget),
      matchesGoldenFile(
        'golden/richer_text_email_catcher.png',
      ),
    );
  });

  testWidgets('Create RicherText with userCatcher',
      (WidgetTester tester) async {
    const text = 'Hello World @test';
    await tester.pumpWidget(
      _TestWidget(
        richerText: RicherText(
          text: text,
          defaultBuilder: (text) => TextSpan(text: text),
          catchers: [RicherTextCatchers.userCatcher()],
        ),
      ),
    );

    expect(find.text(text), findsOneWidget);

    await expectLater(
      find.byType(_TestWidget),
      matchesGoldenFile(
        'golden/richer_text_user_catcher.png',
      ),
    );
  });

  testWidgets('Create RicherText with hashtagCatcher',
      (WidgetTester tester) async {
    const text = 'Hello World #test';
    await tester.pumpWidget(
      _TestWidget(
        richerText: RicherText(
          text: text,
          defaultBuilder: (text) => TextSpan(text: text),
          catchers: [RicherTextCatchers.hashtagCatcher()],
        ),
      ),
    );

    expect(find.text(text), findsOneWidget);

    await expectLater(
      find.byType(_TestWidget),
      matchesGoldenFile(
        'golden/richer_text_hashtag_catcher.png',
      ),
    );
  });
}

class _TestWidget extends StatelessWidget {
  const _TestWidget({Key? key, required this.richerText}) : super(key: key);

  final RicherText richerText;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: richerText,
        ),
      ),
    );
  }
}

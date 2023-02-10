import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isVariableFont = true;

  toggleFontType() {
    setState(() {
      isVariableFont = !isVariableFont;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: this,
      child: isVariableFont
          ? MaterialApp(
              theme: ThemeData(
                fontFamily: 'NotoSansSymbolsVariable',
              ),
              home: const MyHomePage(),
            )
          : MaterialApp(
              theme: ThemeData(
                fontFamily: 'NotoSansSymbols',
              ),
              home: const MyHomePage(),
            ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVariableFont = context.watch<_MyAppState>().isVariableFont;
    final textStyle = isVariableFont
        ? const TextStyle(
            fontVariations: <FontVariation>[
              FontVariation('wght', 700.0),
            ],
          )
        : const TextStyle(
            fontWeight: FontWeight.bold,
          );
    final fontType = isVariableFont ? 'Variable Font' : 'Normal Font';
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$fontType Text Regular'),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$fontType RichText Regular',
                  ),
                ],
              ),
            ),
            Text(
              '$fontType Text Bold',
              style: textStyle,
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$fontType RichText Bold',
                    style: textStyle,
                  ),
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                context.read<_MyAppState>().toggleFontType();
              },
              child: Text(fontType),
            ),
          ],
        ),
      ),
    );
  }
}

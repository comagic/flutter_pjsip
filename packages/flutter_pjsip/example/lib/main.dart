// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pjsip/flutter_pjsip.dart' as flutter_pjsip;
import 'package:flutter_pjsip_example/workers/sum_worker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int? firstSumResult;
  int? secondSumResult;
  bool isCalculating = true;

  @override
  void initState() {
    super.initState();
    initCalculateWorker();
    flutter_pjsip.pjStart();
  }

  Future<void> initCalculateWorker() async {
    final worker = await SumWorker.spawn();
    final firstSum = await worker.getSum(1, 2);
    final secondSum = await worker.getSum(3, 4);

    setState(() {
      firstSumResult = firstSum;
      secondSumResult = secondSum;
      isCalculating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Text(
                  'This calls a native function through FFI that is shipped as '
                  'source in the package. '
                  'The native code is built as part of the Flutter Runner '
                  'build.',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                Text(
                  !isCalculating
                      ? 'background isolate sum(1, 2) = '
                          '$firstSumResult'
                      : 'calculating...',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
                spacerSmall,
                Text(
                  !isCalculating
                      ? 'background isolate sum(3, 4) = '
                          '$secondSumResult'
                      : 'calculating...',
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generate_qr/BarcodeWidget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QA generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'QA generartor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _data = '버튼을 눌러서 URL을 입력하세요!';
  var _canGeneratQA = false;

  void _pasteFromClipboard() async {
    ClipboardData? clipboardData =
        await Clipboard.getData(Clipboard.kTextPlain);

    setState(() {
      if (clipboardData?.text == null || clipboardData?.text == "") {
        _data = '복사 된 URL이 없습니다...';
        _canGeneratQA = false;
      } else {
        _data = clipboardData?.text ?? '복사 된 URL이 없습니다...';
        _canGeneratQA = true;
      }
    });
  }

  void _generateQA(String qrData) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              BarcodeGenerateWidget(qrText: qrData),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_data),
              IconButton(
                icon: const Icon(Icons.paste),
                onPressed: _pasteFromClipboard,
              )
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _generateQA(_data),
        child: const Icon(Icons.get_app),
      ),
    );
  }
}
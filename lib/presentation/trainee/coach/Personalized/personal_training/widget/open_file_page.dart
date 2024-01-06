import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PDFScreen extends StatefulWidget {
  final String pdfURL;

  const PDFScreen({required this.pdfURL, super.key}); // Replace with your PDF URL

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  String? _localPath;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    downloadPDF(widget.pdfURL).then((value) {
      setState(() {
        _localPath = value.path;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: _localPath,
            ),
    );
  }

  Future<File> downloadPDF(String url) async {
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await http.get(Uri.parse(url));
    var bytes = request.bodyBytes;
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}

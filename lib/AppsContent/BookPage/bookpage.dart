import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:get/get.dart';

import '../controller/pdf_controller.dart';

class bookpage extends StatelessWidget {
  final String bookUrl;
  const bookpage({super.key, required this.bookUrl});

  @override
  Widget build(BuildContext context) {
    PdfController pdfController = Get.put(PdfController());
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white,),
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('book title', style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          pdfController.pdfViewerKey.currentState?.openBookmarkView();
        },
      ),
      body: SfPdfViewer.network(
        bookUrl,
        key: pdfController.pdfViewerKey,
      ),
    );
  }
}


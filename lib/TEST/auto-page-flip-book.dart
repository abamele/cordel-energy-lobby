import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class AutoPdfViewerWeb extends StatefulWidget {
  const AutoPdfViewerWeb({super.key});

  @override
  State<AutoPdfViewerWeb> createState() => _AutoPdfViewerWebState();
}

class _AutoPdfViewerWebState extends State<AutoPdfViewerWeb> {
  final PdfViewerController _pdfController = PdfViewerController();
  Timer? _timer;
  int _currentPage = 1;
  int _pageCount = 0;

  @override
  void dispose() {
    _timer?.cancel();
    _pdfController.dispose();
    super.dispose();
  }

  void _startAutoPaging() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_pageCount == 0) return;

      if (_currentPage < _pageCount) {
        _currentPage++;
      } else {
        _currentPage = 1;
      }

      _pdfController.jumpToPage(_currentPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SfPdfViewer.network(
            // ⚠️ URL'yi build/web yapısına göre ayarlıyoruz:
            'https://www.cordel.com.tr/katalog/#flipbook-df_26573/1/',
            controller: _pdfController,
            onDocumentLoaded: (details) {
              setState(() {
                _pageCount = details.document.pages.count;
              });
              _startAutoPaging();
            },
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Sayfa $_currentPage / $_pageCount',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

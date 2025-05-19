import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<String?> extractPdfText(PlatformFile file) async {
  try {
    final Uint8List bytes = file.bytes ?? await File(file.path!).readAsBytes();

    final PdfDocument document = PdfDocument(inputBytes: bytes);
    final String? text = PdfTextExtractor(document).extractText();

    document.dispose(); // تحرير الموارد

    return text?.trim().isEmpty == true ? null : text;
  } catch (e) {
    print('❌ Error reading PDF: $e');
    return null;
  }
}

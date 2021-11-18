import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class PdfApi {
  static Future<File> generatePdf(String testoDaInserireInPDF, String nomeAzienda) async {
    final pdf = Document();
    pdf.addPage(
      Page(
        build: (context) => Center(
          child: Text(testoDaInserireInPDF, textAlign: TextAlign.left),
        ),
      ),
    );

    return saveDocument(name: 'Report $nomeAzienda', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name.pdf');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Future<List<String?>> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    return result == null ? <String>[] : result.paths;
  }
}

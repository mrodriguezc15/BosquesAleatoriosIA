import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadDataPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoadDataPageState createState() => _LoadDataPageState();
}

class _LoadDataPageState extends State<LoadDataPage> {
  String filePath = '';

  Future<void> _pickFile() async {
    // Solicitar permisos
    var status = await Permission.storage.request();
    var statusRead = await Permission.storage.request();
    var statusWrite = await Permission.storage.request();

    if (status.isGranted && statusRead.isGranted && statusWrite.isGranted) {
      // Si los permisos fueron otorgados, permitir seleccionar un archivo
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv', 'xls'],
      );

      if (result != null) {
        setState(() {
          filePath = result.files.single.path ?? '';
        });
      }
    } else {
      // Si el usuario no otorga permisos, puedes manejarlo aquí
      print('El usuario no otorgó permisos para leer el almacenamiento externo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cargar Nuevos Datos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Cargar Nuevos Datos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Seleccionar Archivo'),
            ),
            SizedBox(height: 20),
            if (filePath.isNotEmpty)
              Text(
                'Archivo Seleccionado: $filePath',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

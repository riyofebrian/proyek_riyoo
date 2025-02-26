import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:riyo/models/msiswa.dart';
import 'package:riyo/models/api.dart';
import 'package:riyo/views/form.dart';

class Edit extends StatefulWidget {
  final SiswaModel sw;

  Edit({required this.sw});

  @override
  EditState createState() => EditState();
}
class EditState extends State<Edit> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nisController,
      namaController,
      tpController,
      tgController,
      kelaminController,
      agamaController,
      alamatController;

  Future editSw() async {
    return await http.post(
      Uri.parse(BaseUrl.edit),
      body: {
        "id": widget.sw.id.toString(),
        "nis": nisController.text,
        "nama": namaController.text,
        "tplahir": tpController.text,
        "tglahir": tgController.text,
        "kelamin": kelaminController.text,
        "agama": agamaController.text,
        "alamat": alamatController.text,
      },
    );
  }

  pesan() {
    Fluttertoast.showToast(
      msg: "Perubahan Data Berhasil disimpan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    nisController = TextEditingController(text: widget.sw.nis);
    namaController = TextEditingController(text: widget.sw.nama);
    tpController = TextEditingController(text: widget.sw.tplahir);
    tgController = TextEditingController(text: widget.sw.tglahir);
    kelaminController = TextEditingController(text: widget.sw.kelamin);
    agamaController = TextEditingController(text: widget.sw.agama);
    alamatController = TextEditingController(text: widget.sw.alamat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ), // AppBar
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text("Confirm"),
          onPressed: () {
            _onConfirm(context);
          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: AppForm(
            formkey: formKey,
            nisController: nisController,
            namaController: namaController,
            tpController: tpController,
            tgController: tgController,
            kelaminController: kelaminController,
            agamaController: agamaController,
            alamatController: alamatController,
          ), // AppForm
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riyo/models/api.dart';
import 'package:riyo/models/msiswa.dart';
import 'package:riyo/views/edit.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class Details extends StatefulWidget {
  final SiswaModel sw;
  Details({required this.sw});

  @override
  DetailState createState() => DetailState();
}

class DetailState extends State<Details> {
  void deleteSiswa(context) async {
    http.Response response = await http.post(
      Uri.parse(BaseUrl.hapus),
      body: {
        'id': widget.sw.id.toString(),
      },
    );

    final data = json.decode(response.body);
    if (data['success']) {
      pesan();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  pesan() {
    Fluttertoast.showToast(
      msg: "Penghapusan Data Berhasil disimpan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Apakah anda yakin akan menghapus data ini?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.cancel),
            ),
            ElevatedButton(
              onPressed: () => deleteSiswa(context),
              child: Icon(Icons.check_circle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID : ${widget.sw.id}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "NIS : ${widget.sw.nis}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "NAMA : ${widget.sw.nama}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Tempat Lahir : ${widget.sw.tplahir}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Tanggal Lahir : ${widget.sw.tglahir}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Kelamin : ${widget.sw.kelamin}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Agama : ${widget.sw.agama}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Alamat : ${widget.sw.alamat}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.all(10)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => Edit(sw: widget.sw),
          ),
        ),
      ),
    );
  }
}
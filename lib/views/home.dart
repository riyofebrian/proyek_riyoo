import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riyo/models/msiswa.dart';
import 'package:riyo/models/api.dart';
// import 'package:biodata/views/details.dart';
// import 'package:biodata/views/create.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<SiswaModel>> sw;
  final swListKey = GlobalKey<HomeState>();

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<SiswaModel>> getSwList() async {
    final response = await http.get(Uri.parse(BaseUrl.data));
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<SiswaModel> sw = items.map<SiswaModel>((json) {
      return SiswaModel.fromJson(json);
    }).toList();
    return sw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<SiswaModel>>(
          future: sw,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      data.nis + " " + data.nama,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(data.tplahir + ", " + data.tglahir),
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(
                      //   builder: (context) => Details(sw: data),
                      // ));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        hoverColor: Colors.green,
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return CreateSiswa();
          }));
        },
      ),
    );
  }
}

class CreateSiswa extends StatefulWidget {
  @override
  _CreateSiswaState createState() => _CreateSiswaState();
}

class _CreateSiswaState extends State<CreateSiswa> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nisController = new TextEditingController();
  TextEditingController namaController = new TextEditingController();
  TextEditingController tpController = new TextEditingController();
  TextEditingController tgController = new TextEditingController();
  TextEditingController kelaminController = new TextEditingController();
  TextEditingController agamaController = new TextEditingController();
  TextEditingController alamatController = new TextEditingController();

  Future createSw() async {
    return await http.post(
      Uri.parse(BaseUrl.tambah),
      body: {
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

  void _onConfirm(context) async {
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if (data['success']) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text("Simpan"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.green,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              print("OK SUKSES");
              _onConfirm(context);
            }
          },
        ),
      ),
      body: Container(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AppForm extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController nisController,
      namaController,
      tpController,
      tgController,
      kelaminController,
      agamaController,
      alamatController;

  AppForm({
    required this.formkey,
    required this.nisController,
    required this.namaController,
    required this.tpController,
    required this.tgController,
    required this.kelaminController,
    required this.agamaController,
    required this.alamatController,
  });

  AppFormState createState() => AppFormState();
}
class AppFormState extends State<AppForm> {
  late String _kelamin, _agama, _alamat;
  final _status = ["", "Laki-laki", "Perempuan"];
  final List<String> items = [
    "",
    "Islam",
    "Katholik",
    "Protestan",
    "Hindu",
    "Budha",
    "Khonghucu",
    "Kepercayaan",
  ];

  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(padding: EdgeInsets.all(12)),
            txtNis(),
            txtNama(),
            txtTempat(),
            txtTanggal(),
            tbKelamin(),
            tbAgama(),
            tbAlamat(),
          ],
        ),
      ),
    );
  }

  txtNis() {
    return TextFormField(
      controller: widget.nisController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "NIS",
        prefixIcon: Icon(Icons.card_membership),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ), // OutlineInputBorder
      ), // InputDecoration
      validator: (value) {
        // Validation function for the name field
        if (value!.isEmpty) {
          return 'Masukkan NIS Kelahiran Anda.'; // Return an error message if the name is empty
        }
        return null; // Return null if the name is valid
      },
    ); // TextFormField
  }

  txtNama() {
    return TextFormField(
      controller: widget.namaController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "NAMA",
        prefixIcon: Icon(Icons.note),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ), // OutlineInputBorder
      ), // InputDecoration
      validator: (value) {
        // Validation function for the name field
        if (value!.isEmpty) {
          return 'Masukkan Nama Anda.'; // Return an error message if the name is empty
        }
        return null; // Return null if the name is valid
      },
    ); // TextFormField
  }

  txtTempat() {
    return TextFormField(
      controller: widget.tpController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Tempat Lahir",
        prefixIcon: Icon(Icons.location_city),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ), // OutlineInputBorder
      ), // InputDecoration
      validator: (value) {
        // Validation function for the name field
        if (value!.isEmpty) {
          return 'Masukkan Kota Kelahiran Anda.'; // Return an error message if the name is empty
        }
        return null; // Return null if the name is valid
      },
    ); // TextFormField
  }

  txtTanggal() {
    return TextFormField(
      readOnly: true,
      controller: widget.tgController,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today),
        labelText: 'Tanggal Lahir',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ), // OutlineInputBorder
      ),
      // InputDecoration
      onTap: () async {
        await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(DateTime
              .now()
              .year - 150),
          lastDate: DateTime(
              DateTime
                  .now()
                  .year, DateTime
              .now()
              .month, DateTime
              .now()
              .day
          ), // DateTime
        ).then((tglahir) {
          if (tglahir != null) {
            widget.tgController.text = DateFormat('yyyy-MM-dd').format(tglahir);
          }
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Masukkan Tanggal Lahir Anda.';
        }
        return null;
      },
    ); // TextFormField
  }

  tbKelamin() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        // labelText: 'Jenis Kelamin',
        prefixIcon: Icon(Icons.social_distance),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ), // OutlineInputBorder
      ),
      // InputDecoration
      value: widget.kelaminController.text,
      hint: Text('Jenis Kelamin'),
      onChanged: (String? newValue) {
        setState(() {
          _kelamin = newValue!;
          widget.kelaminController.text = _kelamin;
        });
      },
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Silakan Pilih Jenis Kelamin Anda.';
        }
        return null;
      },
      items: _status.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  tbAgama() {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: "Agama",
        prefixIcon: Icon(Icons.mosque),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ), // OutlineInputBorder
      ),
      // InputDecoration
      value: widget.agamaController.text,
      hint: const Text(
        'Pilih Agama',
        style: TextStyle(fontSize: 14),
      ),
      // Text
      items: items
          .map((item) =>
          DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.blue,
              ), // TextStyle
            ), // Text
          )) // DropdownMenuItem
          .toList(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Silakan Pilih Agama.';
        }
        return null;
      },
      onChanged: (value) {
        _agama = value.toString();
        widget.agamaController.text = _agama;
        // Do something when selected item is changed.
      },
      onSaved: (value) {
        _agama = value.toString();
        widget.agamaController.text = _agama;
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      // ButtonStyleData
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ), // Icon
        iconSize: 24,
      ),
      // IconStyleData
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ), // BoxDecoration
      ),
      // DropdownStyleData
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  tbAlamat() {
    return TextFormField(
      controller: widget.alamatController,
      decoration: InputDecoration(
        labelText: 'Alamat',
        prefixIcon: Icon(Icons.location_on),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ), // OutlineInputBorder
      ), // InputDecoration
      validator: (value) {
        // Validation function for the name field
        if (value!.isEmpty) {
          return 'Silahkan Masukkan Alamat Anda.'; // Return an error message if the name is empty
        }
        return null; // Return null if the name is valid
      },
      onSaved: (value) {
        _alamat = value!;
      },
    ); // TextFormField
  }
}
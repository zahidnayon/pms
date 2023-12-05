import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pms/components/text_field.dart';

class AddNewItemScreen extends StatefulWidget {
  const AddNewItemScreen({Key? key}) : super(key: key);

  @override
  _AddNewItemScreenState createState() => _AddNewItemScreenState();
}

class _AddNewItemScreenState extends State<AddNewItemScreen> {
  final TextEditingController _mutypeTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
  TextEditingController();
  final TextEditingController _statusTEController = TextEditingController();

  Future<void> createNewItem() async {
    final Map<String, dynamic> newItemData = {
      'UNID': '-100',
      'MUTYPE': _mutypeTEController.text.trim(),
      'DESCRIPTION': _descriptionTEController.text.trim(),
      'STATUS': _statusTEController.text.trim(),
      'ACSID': 1,
      'UPSTATUS': 'NewUPSTATUS',
      'DNSTATUS': 'NewDNSTATUS',
      'USRID': 'NewUSRID',
      'BID': 'NewBID',
    };

    final url = Uri.parse('https://api.flexinfosys.com/api/Unit');

    final jsonData = jsonEncode(newItemData);
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonData);
      if (response.statusCode == 200) {
        final decodeBody = jsonDecode(response.body);
        if (decodeBody["status"] == "success") {
          _mutypeTEController.clear();
          _descriptionTEController.clear();
          _statusTEController.clear();
        }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("New item added successfully.")),
          );
      }
    } catch (e) {
      print('Error during POST request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Item'),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 12,bottom: 8),
        child: Column(
          children: [
            MyTextField(
              controller: _mutypeTEController,
                hintText: 'MUTYPE',
            ),
            const SizedBox(height: 8),
            MyTextField(
              controller: _descriptionTEController,
                hintText: 'DESCRIPTION',
            ),
            const SizedBox(height: 8),
            MyTextField(
              controller: _statusTEController,
                hintText: 'STATUS',
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: createNewItem,
              child: const Text('Add New'),
            ),
          ],
        ),
      ),
    );
  }
}

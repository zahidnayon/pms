import 'package:flutter/material.dart';
import 'package:pms/api_services/unid_api.dart';
import 'add_new_item_screen.dart';

class UnidScreen extends StatefulWidget {
  const UnidScreen({Key? key});

  @override
  _UnidScreenState createState() => _UnidScreenState();
}

class _UnidScreenState extends State<UnidScreen> {
  List<dynamic> data = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final result = await UnidApi.fetchUnitData();

      setState(() {
        data = result;
        isLoading = false;
        errorMessage = '';
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Unit API'),
        actions: [
          IconButton(
            onPressed: fetchData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : errorMessage.isNotEmpty
            ? Text(errorMessage)
            : ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return Card(
              child: ListTile(
                title: Text('UNID: ${item['UNID'] ?? 'UNID not available'}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MUTYPE: ${item['MUTYPE'] ?? 'MUTYPE not available'}'),
                    Text('DESCRIPTION: ${item['DESCRIPTION'] ?? 'DESCRIPTION not available'}'),
                    Text('STATUS: ${item['STATUS'] ?? 'STATUS not available'}'),
                    Text('ACSID: ${item['ACSID'] ?? 'ACSID not available'}'),
                    Text('UPSTATUS: ${item['UPSTATUS'] ?? 'UPSTATUS not available'}'),
                    Text('DNSTATUS: ${item['DNSTATUS'] ?? 'DNSTATUS not available'}'),
                    Text('USRID: ${item['USRID'] ?? 'USRID not available'}'),
                    Text('BID: ${item['BID'] ?? 'BID not available'}'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddNewItemScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

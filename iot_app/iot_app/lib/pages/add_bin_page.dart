import 'package:flutter/material.dart';
import 'package:geolocator/geolocator';

class AddBinPage extends StatefulWidget {
  const AddBinPage({Key? key}) : super(key: key);

  @override
  State<AddBinPage> createState() => _AddBinPageState();
}

class _AddBinPageState extends State<AddBinPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _binNameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a bin name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter bin location',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter bin location';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Add functionality to save bin here
                    String binName = _binNameController.text;
                    String location = _locationController.text;
                    print('Bin Name: $binName');
                    print('Location: $location');
                  }
                },
                child: Text('Add Bin'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _binNameController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class requestDocs extends StatefulWidget {
  const requestDocs({super.key});

  @override
  State<requestDocs> createState() => _requestDocsState();
}

class _requestDocsState extends State<requestDocs> {
  //for dropdown button
  var roles = ["Student", "Alumini", "Staff", "Guard"];
  String? role;
  var doc = docs.toString();
  String? selecteddoc;
  //for file upload
  File? _selectedFile;

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
      //type: FileType.custom,
      //allowedExtensions: ['jpg', 'pdf', 'doc'],
    //);

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

Future<void> uploadPdf(File _selectedFile) async {

  var request = http.MultipartRequest('POST', Uri.parse('https://poojan16.pythonanywhere.com/api/create_docreq/'));
  request.headers['Content-Type'] = 'multipart/form-data';
  //request.files.add(await http.MultipartFile.fromPath('file', _selectedFile.path));
  request.fields['full_name'] = "Abhishek Engraver";
  request.fields['doc_id'] = '1';
  request.fields['doc_name'] = selecteddoc.toString();
  request.fields['num_of_copies'] = '1';
  request.fields['additional_instructions'] = 'NA';
  request.fields['purpose'] = 'NA';
  request.fields['requester_role'] = finalrole;
  request.fields['requester_enrolment'] = finalEnrollment;
  request.files.add(http.MultipartFile.fromBytes('file', await File(_selectedFile.toString()).readAsBytes()));
  print(request.files);
  print(request.fields['requester_role']);

  var response = await request.send();

  if(response.statusCode == 201){

    print("Successfully Uploaded");
  }
  else if(response.statusCode == 403){
    print(response.reasonPhrase);
  }
  else if(response.statusCode == 404){
    print(response.reasonPhrase);
  }
  else if(response.statusCode == 405){
    print(response.reasonPhrase);
  }
  //request.fields['num_of_copies'] = '1';

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Request Documents",
          style: TextStyle(color: white),
        ),
        backgroundColor: mainFontColor,
      ),
      backgroundColor: primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Center(
                  child: Text(
                    "Gls University is putting constant efforts to make your interactions with the University offices seamless and are attempting to simplify some processes for you. You may request important documents from the comfort of your home!!",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 420,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(labelText: "Full Name"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   width: 350,
                    //   child: TextField(
                    //     decoration: InputDecoration(labelText: "Doc Id"),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Container(
                    //   width: 350,
                    //   child: TextField(
                    //     decoration: InputDecoration(labelText: "Doc Name"),
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // color: Colors.grey,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: 355,
                      child: DropdownButton(
                        hint: Text("Select Documents"),
                        value: selecteddoc,
                        items: items.map((String selecteddoc) {
                          return DropdownMenuItem(
                              value: selecteddoc, child: Text(selecteddoc));
                        }).toList(),
                        onChanged: (String? selectedValue) {
                          setState(() {
                            selecteddoc = selectedValue!;
                          });
                        },
                        style: TextStyle(fontSize: 15, color: Colors.black),
                        isExpanded: true,
                        elevation: 8,
                        underline: Container(),
                      ),
                    ),
                    
                    SizedBox(
                      height: 6,
                    ),
                    Container(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(labelText: "Purpose"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: "Additional Instructions"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(labelText: "No of Copies"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 6,
                        ),
                        ElevatedButton(
                          onPressed: _openFileExplorer,
                          child: Text('Upload pdf'),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Container(
                          width: 180,
                          child: _selectedFile != null
                              ? Text('Selected File: ${_selectedFile!.path}')
                              : Text('No file selected'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Charges 200/- for One Copy",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    print(doc);
                    print(items);
                    print(selecteddoc);
                    String? var1 = _selectedFile?.path.toString();
                    print("Vishal:"+ var1!);
                    await uploadPdf(_selectedFile!);
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttoncolor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

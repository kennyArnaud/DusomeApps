import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';


class AddBook extends StatefulWidget {
  const AddBook({super.key});

  @override
  State<AddBook> createState() => _AddBookState();

}

class _AddBookState extends State<AddBook> {

  String? title;
  String? description;
  String? language;
  String? page;
  XFile? imageFile;

  final ImagePicker picker = ImagePicker();
  void takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(
      source: source,
    );
    setState(() {
      imageFile = pickedFile;
    });
  }

  String? _path;
 // dynamic path;
  void openFileExplorer() async {
    var path = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (path != null) {
      _path = path.files.single.path;
      print(_path);
    }
  }
  String? selectedCategory;
  final List<String> categories =
  ['ROMA', 'BIOLOGIE', 'PHYSIQUE', 'CHIMIE','MATHEMATIQUE','INFORMATIQUE'];
  Map<String, bool> selectedCategories = {};
  @override
  void initState() {
    super.initState();
    for (var category in categories) {
      selectedCategories[category] = false;
    }
  }
  //save book

  bool isLoading = false; // Add a loading state

  // Function to save book data to Firebase
  Future<void> saveBook() async {
    if (title == null || description == null || language == null || page == null || _path == null || imageFile == null) {
      // Show an error message if any field is missing
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields, select a PDF file, and an image.')),
      );
      return;
    }

    setState(() {
      isLoading = true; // Start loading
    });

    // Show loading spinner
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    try {
      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('book_images/${imageFile!.name}');
      await storageRef.putFile(File(imageFile!.path));
      final imageUrl = await storageRef.getDownloadURL();

      final pdfStorageRef = FirebaseStorage.instance.ref().child('book_pdfs/${(_path!)}');
      await pdfStorageRef.putFile(File(_path!));
      final pdfUrl = await pdfStorageRef.getDownloadURL();

      // Save book data to Firebase Database
      DatabaseReference ref = FirebaseDatabase.instance.ref("books").push();
      await ref.set({
        "title": title,
        "description": description,
        "language": language,
        "page": page,
        "category": selectedCategory,
        "pdfPath": pdfUrl,
        "imageUrl": imageUrl, // Save the image URL
        // Add more fields if necessary
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book saved successfully!')),
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save book: $e')),
      );
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
      Navigator.of(context).pop(); // Close the loading spinner
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 40,horizontal: 20),
              color: Colors.deepPurpleAccent,
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40,),
                          InkWell(
                            onTap: (){
                              takePhoto(ImageSource.gallery);
                            },
                            child: Container(
                              height: 190,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Center(
                                child: imageFile == null
                                    ? Image.asset('assets/Icons/addImage.png')
                                    : Image.file(File(imageFile!.path)),
                              ),
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child:InkWell(
                            onTap: (){
                              openFileExplorer();
                            },
                            child: Container(
                              padding: EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/Icons/upload.png'),
                                  SizedBox(width: 15.0,),
                                  Text('Book PDF',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0,),
                  TextField(
                    onChanged: (value){
                      title = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Book Title',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    maxLines: 5,
                    onChanged: (value){
                      description = value;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Book description',
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                          child:  TextField(
                            onChanged: (value){
                             page = value;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.book),
                              border: OutlineInputBorder(),
                              labelText: 'page',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                      ),
                      SizedBox(width: 10.0,),
                      Expanded(
                          child:  TextField(
                            onChanged: (value){
                              language = value;
                            },
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.language),
                              border: OutlineInputBorder(),
                              labelText: 'Language',
                              labelStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),

                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  //checkbox
                  // ... existing code ...
                  Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedCategory,
                        hint: Text('Select Category'),
                        icon: Icon(Icons.category),
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0,),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: (){
                              
                            },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.red,
                                  )
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: Colors.red,
                                  ),
                                  SizedBox(width: 10.0,),
                                  Text('Cancel',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                          child: InkWell(
                             onTap: (){
                               saveBook();
                             },
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.upload_sharp,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                                  SizedBox(width: 10,),
                                  Text('POST',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

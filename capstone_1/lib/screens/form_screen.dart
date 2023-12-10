import 'dart:io';

import 'package:capstone_1/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TripFormScreen extends StatefulWidget {
  @override
  _TripFormScreenState createState() => _TripFormScreenState();
}

String selectedCategory = "sport";
String selecteCity = "Riyadh";

class _TripFormScreenState extends State<TripFormScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController governorController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? imageFile;

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xff8ECAE6),
            colorScheme: ColorScheme.light(primary: Color(0xff8ECAE6)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future getImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        // backgroundColor: Color(0xff8ECAE6),
        title: Text(
          'Add Your trip now !',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Color(0xff023047)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: getImage,
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Color(0xff8ECAE6),
                      radius: 50,
                      backgroundImage:
                          imageFile != null ? FileImage(imageFile!) : null,
                      child: imageFile == null
                          ? Icon(Icons.camera_alt,
                              size: 50, color: Color(0xffFFB703))
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                SizedBox(height: 16),
                buildStyledTextField(
                  controller: titleController,
                  labelText: 'Trip Title',
                ),
                SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: IgnorePointer(
                    child: buildStyledTextField(
                      controller: dateController,
                      labelText: 'Date',
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xff219EBC),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                buildStyledTextField(
                  controller: governorController,
                  labelText: 'Time',
                ),
                SizedBox(height: 16),
                DropdownButton<String>(
                    value: selecteCity,
                    onChanged: (String? newValue) {
                      setState(() {
                        selecteCity = newValue!;
                      });
                    },
                    items: <String>['Riyadh', 'Jeddah', 'Dammam']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    icon: const Icon(Icons.arrow_drop_down,
                        color: Color(0xff8ECAE6)),
                    iconSize: 30,
                    elevation: 16,
                    style: const TextStyle(color: Color(0xff023047)),
                    underline: Container(
                      height: 2,
                      color: const Color(0xff8ECAE6),
                    ),
                    dropdownColor: Color(0xff8ECAE6)),
                SizedBox(height: 16),
                buildStyledTextField(
                  controller: budgetController,
                  labelText: 'Cost',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                buildStyledTextField(
                  controller: descriptionController,
                  labelText: 'Description',
                  maxLines: 3,
                ),
                SizedBox(height: 32),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: <String>['sport', 'art', 'education', 'hangout']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    );
                  }).toList(),
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Color(0xff8ECAE6)),
                  iconSize: 30,
                  elevation: 16,
                  style: const TextStyle(color: Color(0xff023047)),
                  underline: Container(
                    height: 2,
                    color: const Color(0xff8ECAE6),
                  ),
                  dropdownColor: Color(0xff8ECAE6),
                ),
                SizedBox(height: 30),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     primary: Color(0xff8ECAE6),
                //     minimumSize: Size(double.infinity, 30),
                //   ),
                //   onPressed: () {},
                //   child: Text(
                //     'Publish Trip',
                //     style: TextStyle(
                //         color: Color(0xff023047), fontWeight: FontWeight.bold),
                //   ),
                // ),
                Container(
                  width: 330,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff8ECAE6)),
                  child: const Center(
                    child: Text(
                      "Publish Your Trip",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff023047),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget buildStyledTextField({
  //   required TextEditingController controller,
  //   required String labelText,
  //   int maxLines = 1,
  //   TextInputType keyboardType = TextInputType.text,
  //   Widget? suffixIcon,
  // }) {
  //   return TextFormField(
  //     controller: controller,
  //     maxLines: maxLines,
  //     keyboardType: keyboardType,
  //     style: TextStyle(color: Colors.white),
  //     decoration: InputDecoration(
  //       labelText: labelText,
  //       labelStyle: TextStyle(color: Colors.white),
  //       focusedBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.green[50]!, width: 2),
  //       ),
  //       enabledBorder: OutlineInputBorder(
  //         borderSide: BorderSide(color: Colors.green[50]!, width: 1),
  //       ),
  //       suffixIcon: suffixIcon,
  //     ),
  //   );
  // }
}

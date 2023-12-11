import 'dart:io';

import 'package:capstone_1/blocs/addtrip_bloc/addtrip_bloc.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TripFormScreen extends StatefulWidget {
  @override
  _TripFormScreenState createState() => _TripFormScreenState();
}

String selectedCategory = "sport";
String selecteCity = "Riyadh";

class _TripFormScreenState extends State<TripFormScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // TextEditingController governorController = TextEditingController();
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
    return BlocProvider(
      create: (context) => AddTripBloc(),
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: AppBar(
          // backgroundColor: Color(0xff8ECAE6),
          title: Text(
            'Add Your trip now !',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff023047)),
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
                    controller: timeController,
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
                    controller: costController,
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
                  BlocConsumer<AddTripBloc, AddTripState>(
                    listener: (context, state) {
                      // Handle state changes here
                      if (state is AddTripSuccessState) {
                        // Show a success message or navigate to another screen
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Trip added successfully!'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else if (state is AddTripErrorState) {
                        // Show an error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Failed to add trip: ${state.errorMessage}'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        width: 330,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff8ECAE6),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Trigger the AddTripEvent when the button is pressed
                            context.read<AddTripBloc>().add(
                                  AddTripEvent(
                                    trip: Trip(
                                        title: titleController.text,
                                        time: timeController.text,
                                        date: dateController.text,
                                        category: selectedCategory,
                                        location: selecteCity,
                                        description: descriptionController.text,
                                        cost: int.parse(costController.text),
                                        image: imageFile != null
                                            ? imageFile?.path
                                            : null,
                                        tripCreator: Supabase.instance.client
                                            .auth.currentUser!.id),
                                  ),
                                );
                          },
                          child: const Center(
                            child: Text(
                              'Publish Your Trip',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff023047),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

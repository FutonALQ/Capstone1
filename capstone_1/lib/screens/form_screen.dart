import 'dart:io';

import 'package:capstone_1/blocs/addtrip_bloc/addtrip_bloc.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TripFormScreen extends StatefulWidget {
  const TripFormScreen({super.key});

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
            primaryColor: const Color(0xff8ECAE6),
            colorScheme: const ColorScheme.light(primary: Color(0xff8ECAE6)),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
          title: const Text(
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
                        backgroundColor: const Color(0xff8ECAE6),
                        radius: 50,
                        backgroundImage:
                            imageFile != null ? FileImage(imageFile!) : null,
                        child: imageFile == null
                            ? const Icon(Icons.camera_alt,
                                size: 50, color: Color(0xffFFB703))
                            : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SizedBox(height: 16),
                  buildStyledTextField(
                    controller: titleController,
                    labelText: 'Trip Title',
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: IgnorePointer(
                      child: buildStyledTextField(
                        controller: dateController,
                        labelText: 'Date',
                        suffixIcon: const Icon(
                          Icons.calendar_today,
                          color: Color(0xff219EBC),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  buildStyledTextField(
                    controller: timeController,
                    labelText: 'Time',
                  ),
                  const SizedBox(height: 16),
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
                      dropdownColor: const Color(0xff8ECAE6)),
                  const SizedBox(height: 16),
                  buildStyledTextField(
                    controller: costController,
                    labelText: 'Cost',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  buildStyledTextField(
                    controller: descriptionController,
                    labelText: 'Description',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 32),
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
                    dropdownColor: const Color(0xff8ECAE6),
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<AddTripBloc, AddTripState>(
                    listener: (context, state) {
                      if (state is AddTripSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Trip added successfully!'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (state is AddTripErrorState) {
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
                                            : 'https://www.fabhotels.com/blog/wp-content/uploads/2020/05/road-trip-hacks-tips-600.jpg',
                                        tripCreator: currentUser!.user_uuid),
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

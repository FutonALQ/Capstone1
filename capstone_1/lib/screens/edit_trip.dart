import 'package:capstone_1/blocs/trip_details_bloc/tripdetails_bloc.dart';
import 'package:capstone_1/blocs/trip_details_bloc/tripdetails_event.dart';
import 'package:capstone_1/blocs/trip_details_bloc/tripdetails_state.dart';
import 'package:capstone_1/globals/global_user.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/screens/nav_bar.dart';

import 'package:capstone_1/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditTripScreen extends StatefulWidget {
  final Trip existingTrip;

  const EditTripScreen({Key? key, required this.existingTrip})
      : super(key: key);

  @override
  _EditTripScreenState createState() => _EditTripScreenState();
}

String selectedCategory = "sport";
String selecteCity = "Riyadh";

class _EditTripScreenState extends State<EditTripScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController costController;
  late TextEditingController timeController;
  late TextEditingController dateController;
  late final ImagePicker picker;
  // late File? imageFile;

  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    selectedDate = DateTime.now();
    initializeControllers();
  }

  void initializeControllers() {
    titleController = TextEditingController(text: widget.existingTrip.title);
    descriptionController =
        TextEditingController(text: widget.existingTrip.description);
    costController =
        TextEditingController(text: widget.existingTrip.cost?.toString() ?? '');
    timeController = TextEditingController(text: widget.existingTrip.time);
    dateController = TextEditingController(text: widget.existingTrip.date);

    selecteCity = widget.existingTrip.location!;
    selectedCategory = widget.existingTrip.category!;
  }

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

  // Future getImage() async {
  //   XFile? image = await picker.pickImage(source: ImageSource.gallery);

  //   if (image != null) {
  //     setState(() {
  //       imageFile = File(image.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit',
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
                // GestureDetector(
                //   onTap: getImage,
                //   child: Center(
                //     child: CircleAvatar(
                //       backgroundColor: const Color(0xff8ECAE6),
                //       radius: 50,
                //       backgroundImage:
                //           imageFile != null ? FileImage(imageFile!) : null,
                //       child: imageFile == null
                //           ? const Icon(Icons.camera_alt,
                //               size: 50, color: Color(0xffFFB703))
                //           : null,
                //     ),
                //   ),
                // ),
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
                BlocConsumer<TripDetailsBloc, TripDetailsState>(
                  listener: (context, state) {
                    if (state is TripUpdateSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Trip updated successfully!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else if (state is TripDetailsErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Failed to update trip: ${state.errorMessage}'),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppNavigationBar()));

                          context.read<TripDetailsBloc>().add(
                                UpdateTripEvent(
                                  tripId: widget.existingTrip.id.toString(),
                                  body: {
                                    'title': titleController.text,
                                    'time': timeController.text,
                                    'date': dateController.text,
                                    'category': selectedCategory,
                                    'location': selecteCity,
                                    'description': descriptionController.text,
                                    'cost': int.parse(costController.text),
                                    'creator_id': currentUser!.user_uuid,
                                  },
                                ),
                              );
                        },
                        child: const Center(
                          child: Text(
                            'Edit Your trip',
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
    );
  }
}

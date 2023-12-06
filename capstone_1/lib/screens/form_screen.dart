import 'package:capstone_1/widgets/form_widget.dart';
import 'package:flutter/material.dart';

class TripFormScreen extends StatefulWidget {
  @override
  _TripFormScreenState createState() => _TripFormScreenState();
}

class _TripFormScreenState extends State<TripFormScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController governorController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Trip Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildStyledTextField(
                  controller: titleController,
                  labelText: 'Trip Title',
                ),
                SizedBox(height: 16),
                buildStyledTextField(
                  controller: descriptionController,
                  labelText: 'Description',
                  maxLines: 3,
                ),
                SizedBox(height: 16),
                buildStyledTextField(
                  controller: budgetController,
                  labelText: 'Budget',
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16),
                buildStyledTextField(
                  controller: locationController,
                  labelText: 'Location',
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
                        color: Colors.green[50],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                buildStyledTextField(
                  controller: governorController,
                  labelText: 'Governor',
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[50],
                    minimumSize: Size(double.infinity, 30),
                  ),
                  onPressed: () {},
                  child: Text('Publish Trip'),
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

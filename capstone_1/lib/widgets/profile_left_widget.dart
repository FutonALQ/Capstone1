import 'package:capstone_1/screens/trip_details_screen.dart';
import 'package:capstone_1/services/supabase_request.dart';
import 'package:capstone_1/widgets/trip_countener.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileLeftWidget extends StatelessWidget {
  ProfileLeftWidget({super.key, required this.tripOwnerId});
  String tripOwnerId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 24, right: 24),
      child: FutureBuilder(
          future: getOwnerTrips(tripOwnerId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 50),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 170 / 272,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TripDetailsScreen(
                                        trip: snapshot.data![index],
                                      )));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 4),
                          child: TripCountener(
                            trip: snapshot.data![index],
                          ),
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("error"));
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

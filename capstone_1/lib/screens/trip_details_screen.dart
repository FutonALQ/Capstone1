import 'package:capstone_1/blocs/trip_bloc/trip_bloc.dart';
import 'package:capstone_1/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({
    super.key,
    required this.trip,
  });
  final Trip trip;

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  void initState() {
    context.read<TripBloc>().add(GetUsersEvent(widget.trip));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.trip.title!),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, top: 8.0),
        child: ListView(
          children: [
            Container(
              width: 376,
              height: 320,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.trip.image!),
                  fit: BoxFit.fill,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(34),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    widget.trip.title ?? "-",
                    style: const TextStyle(
                      color: Color(0xFF101018),
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.52,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.trip.description ?? "-",
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF818E9C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Color.fromARGB(155, 251, 134, 0),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 100,
                            child: Text(
                              widget.trip.date ?? "-",
                              style: const TextStyle(
                                color: Color(0xFF818E9C),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: 1,
                        height: 20, // Adjust the height as needed
                        color: Colors.grey, // Adjust the color as needed
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timelapse,
                            color: Color.fromARGB(155, 251, 134, 0),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.trip.time ?? "-",
                            style: const TextStyle(
                              color: Color(0xFF818E9C),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color.fromARGB(155, 251, 134, 0),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 100,
                            child: Text(
                              widget.trip.location ?? "-",
                              style: const TextStyle(
                                color: Color(0xFF818E9C),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Container(
                        width: 1,
                        height: 20, // Adjust the height as needed
                        color: Colors.grey, // Adjust the color as needed
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.monetization_on_rounded,
                            color: Color.fromARGB(155, 251, 134, 0),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.trip.cost.toString(),
                            style: const TextStyle(
                              color: Color(0xFF818E9C),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.trip.link ?? "-",
                    style: const TextStyle(
                      color: Color(0xFF818E9C),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 0.10,
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<TripBloc, TripState>(
                    builder: (context, state) {
                      if (state is GetUserSuccessedState) {
                        return Text(
                          'Trip Creator: ${state.user.name}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }
                      return const Text(
                        '--- ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: 346,
                    height: 55,
                    decoration: BoxDecoration(
                      color: const Color(0xff8ECAE6),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(48),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff8ECAE6).withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        ' JOIN THE TRIP',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

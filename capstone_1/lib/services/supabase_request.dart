import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

addUser(Map body) async {
  final supabase = Supabase.instance.client;
  await supabase.from("users").insert(body).select();
}

Future<List> getUsers() async {
  final supabase = Supabase.instance.client;
  final users = await supabase.from("users").select();
  return users;
}

Future<UserModel> getUser() async {
  final supabase = Supabase.instance.client;
  final String id = Supabase.instance.client.auth.currentUser!.id;
  final response = await supabase.from("users").select('*').eq('user_uuid', id);
  final UserModel user = UserModel.fromJson(response[0]);
  return user;
}

Future<List<Trip>> getTrips({int? id}) async {
  List data = [];
  List<Trip> tripsList = [];
  try {
    if (id != null) {
      data = await Supabase.instance.client
          .from('trips')
          .select('*, a_trip!inner()')
          .eq('a_trip.trip_id', id);
      print(data);
    } else {
      data = await Supabase.instance.client.from('trips').select('*');
    }

    for (var element in data) {
      tripsList.add(Trip.fromJson(element));
    }
  } catch (e) {
    print(e.toString());
  }
  return tripsList;
}

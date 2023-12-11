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

Future<UserModel> getAUser(String id) async {
  final supabase = Supabase.instance.client;
  final response = await supabase.from("users").select('*').eq('user_uuid', id);
  final UserModel user = UserModel.fromJson(response[0]);
  return user;
}

Future<List<Trip>> getTrips({int? Userid}) async {
  List data = [];
  List<Trip> tripsList = [];
  try {
    if (Userid != null) {
      data = await Supabase.instance.client
          .from('trips')
          .select('*, a_trip!inner()')
          .eq('a_trip.joint_id', Userid);
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

Future<List<Trip>> getFollowingTrips({String? id}) async {
  final supabase = Supabase.instance.client;
  List<Trip> tripsList = [];
  List<Trip> followingTripsList = [];
  try {
    final followingList =
        await supabase.from('following').select('*').eq('user_uuid', id);

    tripsList = await getTrips();

    for (var trip in tripsList) {
      for (var following in followingList) {
        if (following['follows_uuid'] == trip.tripCreator) {
          followingTripsList.add(trip);
        }
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return followingTripsList;
}

deleteTrip({required int id}) async {
  final supabase = Supabase.instance.client;
  await supabase.from('a_trip').delete().eq("trip_id", id);
  await supabase.from('trips').delete().eq("id", id);
}

addUserToTrip(Map body) async {
  final supabase = Supabase.instance.client;
  await supabase.from("a_trip").insert(body).select();
}

Future<bool> searchUserInTrip(
    {required String userId, required int tripId}) async {
  final supabase = Supabase.instance.client;
  final List response = await supabase
      .from("a_trip")
      .select('*')
      .match({'joint_id': userId, 'trip_id': tripId});

  if (response.isEmpty) {
    return false;
  }
  return true;
}

unjointTrip({required String userId, required int tripId}) async {
  final supabase = Supabase.instance.client;
  await supabase
      .from('a_trip')
      .delete()
      .match({'joint_id': userId, 'trip_id': tripId});
}

// addTrip(Map<String, dynamic> body) async {
//   final supabase = Supabase.instance.client;
//   await supabase.from("trips").insert(body).select();
// }
addTrip(Map<String, dynamic> body) async {
  final supabase = Supabase.instance.client;
  await supabase.from("trips").upsert(body).select();
}

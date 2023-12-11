import 'package:capstone_1/models/trip.dart';
import 'package:capstone_1/models/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

addUser(Map body) async {
  final supabase = Supabase.instance.client;
  await supabase.from("users").insert(body).select();
}

/// *****************************START*********************************
/// *****************************DONE*********************************
Future<List<UserModel>> getUsers() async {
  final supabase = Supabase.instance.client;
  final users = await supabase.from("users").select();
  final List<UserModel> usersObjectList = [];

  for (var element in users) {
    usersObjectList.add(UserModel.fromJson(element));
  }
  return usersObjectList;
}

/// *****************************DONE*********************************
Future<List<UserModel>> getFollowing(String userId) async {
  final supabase = Supabase.instance.client;
  final List following = await supabase
      .from('following')
      .select('follows_uuid')
      .eq('user_uuid', userId);
  final List users = await supabase.from('users').select();
  List joinList = [];
  List<UserModel> usersObject = [];
  for (var followingUsers in following) {
    for (var element in users) {
      if (followingUsers['follows_uuid'] == element['user_uuid']) {
        joinList.add(element);
      }
    }
  }
  for (var element in joinList) {
    usersObject.add(UserModel.fromJson(element));
  }
  return usersObject;
}

/// *****************************DONE*********************************
Future<List<UserModel>> getFollowers(String userId) async {
  final supabase = Supabase.instance.client;
  final List followers = await supabase
      .from('followers')
      .select('followed_uuid')
      .eq('user_uuid', userId);
  final List users = await supabase.from('users').select();
  List joinList = [];
  List<UserModel> usersObject = [];
  for (var followersUsers in followers) {
    for (var element in users) {
      if (followersUsers['followed_uuid'] == element['user_uuid']) {
        joinList.add(element);
      }
    }
  }
  for (var element in joinList) {
    usersObject.add(UserModel.fromJson(element));
  }
  return usersObject;
}

/// ****************************DONE*******************************
Future<void> follow(String userId, String followUserId) async {
  final supabase = Supabase.instance.client;
  await supabase
      .from('following')
      .insert({'user_uuid': userId, 'follows_uuid': followUserId});
  await supabase
      .from('followers')
      .insert({'user_uuid': followUserId, 'followed_uuid': userId});
  print('DONE');
}

// / *************************DONE**********************************
Future<void> unfollow(String unFollowUserId) async {
  final supabase = Supabase.instance.client;
  await supabase.from('following').delete().eq('follows_uuid', unFollowUserId);
  await supabase.from('followers').delete().eq('user_uuid', unFollowUserId);
  print('DONE');
}

/// ***************************DONE********************************
Future<bool> isAFollower(String currentUser, String checkUser) async {
  // currentUser ==> 'd33d895d-ab10-40b2-90d6-badf3917425b'
  // checkUser ==> '42c953d5-cc40-4406-b933-9a643cfe6842'
  bool isAfollower = false;
  final supabase = Supabase.instance.client;
  final List following = await supabase.from('following').select();

  for (var element in following) {
    if (element['user_uuid'] == currentUser &&
        element['follows_uuid'] == checkUser) {
      isAfollower = true;
      break;
    } else {
      isAfollower = false;
    }
  }
  return isAfollower;
}

/// **************************************************************
Future<List<Trip>> getOwnerTrips(String userID) async {
  final supabase = Supabase.instance.client;
  final trips = await supabase.from("trips").select().eq('creator_id', userID);
  final List<Trip> tripsObjectList = [];
  for (var element in trips) {
    tripsObjectList.add(Trip.fromJson(element));
  }

  print(
      '%%%%%%%%%%%%%%%%%%%%%%\n${tripsObjectList.first.title}\n%%%%%%%%%%%%%%%%%%%%%%');
  return tripsObjectList;
}

/// ____________________________________________________________

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

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

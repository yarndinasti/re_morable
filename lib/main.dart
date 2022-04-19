import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/home/index.dart';
import 'modules/utils/notification.dart';

// Routes
import 'modules/utils/save_local.dart';
import 'models/members_model.dart';
// End Routes

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotif();

  // fetch (data/members.json)
  final members = await rootBundle.loadString('data/members.json');
  final MembersModel memberList = MembersModel.fromJson(json.decode(members));

  SaveLocal.membersData = memberList.members;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    runNotif();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Index(),
    );
  }
}

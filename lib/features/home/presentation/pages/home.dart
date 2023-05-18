import 'package:flutter/material.dart';

import '../../../../config/Cache/cache_helper.dart';
import '../../../../config/resources/cache_keys.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final role = Cache.getData(key: CacheKeys.role);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(role == 'doctor' ? 'Home' : 'Title'),
      ),
      body: Container(),
    );
  }
}

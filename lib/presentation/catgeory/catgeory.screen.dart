import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/catgeory.controller.dart';

class CatgeoryScreen extends GetView<CatgeoryController> {
  const CatgeoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CatgeoryScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CatgeoryScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class DataController extends GetxController {
  var activityList = <dynamic>[].obs;
  var isLoading = false.obs;
  ScrollController scrollController = ScrollController();
  int _page = 1;
  final int _limit = 10;

  @override
  void onInit() {
    fetchData();
   
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        fetchData();
      }
    });
    super.onInit();
  }

  Future<void> fetchData() async {
    if (isLoading.value) return;
    isLoading.value = true;
    
   
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_page=$_page&_limit=$_limit');
    
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List newData = json.decode(response.body);
        if(newData.isNotEmpty) {
          activityList.addAll(newData);
          _page++;
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
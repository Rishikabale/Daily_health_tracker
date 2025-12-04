import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/activity_model.dart';

class HomeController extends GetxController {
  
  var timerValue = 600.obs; 
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    fetchActivities();
    startTimer();      
  }


  void startTimer() {
    
    _timer?.cancel();
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerValue.value > 0) {
        timerValue.value--;
      } else {
      
        timerValue.value = 600; 
      }
    });
  }

  void resetTimer() {
    timerValue.value = 600; 
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  var activityLogs = <ActivityLog>[].obs;
  var isLoading = false.obs;
  var hasMore = true.obs;
  int _page = 1;
  final int _limit = 10;

  Future<void> fetchActivities() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      // Using JSONPlaceholder as the mock API
      final url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_page=$_page&_limit=$_limit');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        
        if (jsonResponse.isEmpty) {
          hasMore.value = false; 
        } else {
          var newLogs = jsonResponse.map((e) => ActivityLog.fromJson(e)).toList();
          activityLogs.addAll(newLogs);
          _page++; 
        }
      }
    } catch (e) {
      print("Error fetching activities: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
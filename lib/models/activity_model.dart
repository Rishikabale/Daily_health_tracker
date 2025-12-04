class ActivityLog {
  final int id;
  final String title;
  final String subtitle;
  final String iconUrl;

  ActivityLog({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.iconUrl,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    
    List<String> englishTitles = [
      "Morning Jog",
      "Yoga Session", 
      "Hydration Goal",
      "Evening Walk", 
      "Cycling", 
      "Meditation",
      "Gym Workout", 
      "Healthy Breakfast"
    ];

    List<String> englishSubtitles = [
      "Ran 5km in the city park today.",
      "Completed 30 minutes of stretching.",
      "Drank 8 glasses of water to stay hydrated.",
      "Walked 6,000 steps after dinner.",
      "Cycled 15km through the neighborhood.",
      "Meditated for 10 mins to relax.",
      "Focused on strength training today.",
      "Ate oatmeal with fruits and nuts."
    ];


    // (We use the modulo operator % so it always finds a match)
    int id = json['id'] ?? 0;
    int index = id % englishTitles.length;

    return ActivityLog(
      id: id,
      title: englishTitles[index],     
      subtitle: englishSubtitles[index], 
      iconUrl: "https://cdn-icons-png.flaticon.com/512/2964/2964514.png", // Safe hardcoded icon
    );
  }
}
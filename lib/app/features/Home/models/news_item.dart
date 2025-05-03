class NewsModel {
  final String title;
  final String description;
  final DateTime time;

  NewsModel({
    required this.title,
    required this.description,
    required this.time,
  });

  // Format waktu jika kamu ingin pakai string langsung
  String get formattedTime {
    final duration = DateTime.now().difference(time);
    if (duration.inMinutes < 1) return 'Baru saja';
    if (duration.inMinutes < 60) return '${duration.inMinutes} menit lalu';
    if (duration.inHours < 24) return '${duration.inHours} jam lalu';
    return '${duration.inDays} hari lalu';
  }
}

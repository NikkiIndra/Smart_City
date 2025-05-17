class NewsModel {
  final String title;
  final String author;
  final String imageUrl;
  final DateTime postedOn;

  NewsModel({
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.postedOn,
  });

  // Format waktu jika kamu ingin pakai string langsung
  String get formattedTime {
  final duration = DateTime.now().difference(postedOn);

  if (duration.inMinutes < 1) {
    return 'Baru saja';
  } else if (duration.inMinutes < 60) {
    return '${duration.inMinutes} menit lalu';
  } else if (duration.inHours < 24) {
    return '${duration.inHours} jam lalu';
  } else if (duration.inDays < 7) {
    return '${duration.inDays} hari lalu';
  } else {
    return '${postedOn.day}/${postedOn.month}/${postedOn.year}';
  }
}

}

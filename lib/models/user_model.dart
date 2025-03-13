class User{
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String imageUrl;
  final bool isOnline;
  final bool hasStory;
  final int age;
  final String lastOnline;
  final double score;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.imageUrl,
    required this.isOnline,
    required this.hasStory,
    required this.age,
    required this.lastOnline,
    required this.score,
 });
}
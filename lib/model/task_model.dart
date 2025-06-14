class TaskModel {
  final String id;
  final String title;
  final String description;

  TaskModel({required this.id, required this.title, required this.description});

  factory TaskModel.fromMap(String id, Map<String, dynamic> data) {
    return TaskModel(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
    );
  }
}

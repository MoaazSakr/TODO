class TaskModel{
  String? createdAt;
  String? description;
  int? id;
  String? imagePath;
  String? title;
  String? group;

  TaskModel({this.createdAt, this.description, this.id, this.imagePath, this.title});

  TaskModel.fromJson(Map<String, dynamic> json){
    createdAt = json['created_at'];
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    title = json['title'];
  }

  Map<String, dynamic> toJson(){
    return {
      'created_at': createdAt,
      'description': description,
      'id': id,
      'image_path': imagePath,
      'title': title
    };
  }
}
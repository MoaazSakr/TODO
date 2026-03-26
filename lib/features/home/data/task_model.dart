class TaskModel{
  String? endTime;
  String? description;
  int? id;
  String? imagePath;
  String? title;
  String? group;

  TaskModel({this.endTime, this.description, this.id, this.imagePath, this.title});

  TaskModel.fromJson(Map<String, dynamic> json){
    endTime = json['end_time'];
    description = json['description'];
    id = json['id'];
    imagePath = json['image_path'];
    title = json['title'];
  }

  Map<String, dynamic> toJson(){
    return {
      'end_time': endTime,
      'description': description,
      'id': id,
      'image_path': imagePath,
      'title': title
    };
  }
}
class ProjectModel{

  int id;
  int color;
  String name;
  int comment_count;
  bool shared;
  bool favorite;
  int sync_id;
  bool inbox_project;

  ProjectModel({this.id, this.color, this.name, this.comment_count, this.shared, this.favorite, this.sync_id, this.inbox_project});

  factory ProjectModel.fromJson(Map<String, dynamic> json){
    return ProjectModel(
      id: json['id'],
      color: json['color'],
      name: json['name'],
      comment_count: json['comment_count'],
      shared: json['shared'],
      favorite: json['favorite'],
      sync_id: json['sync_id'],
      inbox_project: json['inbox_project'],
    );
  }

}
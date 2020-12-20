class TaskModel{
  int id;
  int assigner;
  int project_id;
  int section_id;
  int order;
  String content;
  bool completed;
  List<dynamic> label_ids;
  int priority;
  int comment_count;
  int creator;
  String created;
  String url;

  TaskModel({this.id, this.assigner, this.project_id, this.section_id, this.order, this.content, this.completed, this.label_ids, this.priority,
  this.comment_count, this.creator, this.created, this.url});

  factory TaskModel.fromJson(Map<String, dynamic> json){
    return TaskModel(
      id: json['id'],
      assigner: json['assigner'],
      project_id: json['project_id'],
      section_id: json['section_id'],
      order: json['order'],
      content: json['content'],
      completed: json['completed'],
      label_ids: json['label_ids'],
      priority: json['priority'],
      comment_count: json['comment_count'],
      creator: json['creator'],
      created: json['created'],
      url: json['url'],
    );
  }

/*
          "id": 4427790485,
        "assigner": 0,
        "project_id": 2253013032,
        "section_id": 0,
        "order": 1,
        "content": "Makan Sore Jam 15.00",
        "completed": false,
        "label_ids": [],
        "priority": 1,
        "comment_count": 0,
        "creator": 31522901,
        "created": "2020-12-20T05:58:41Z",
        "url": "https://todoist.com/showTask?id=4427790485"
  */


}
class ChatModel {
  int? id;
  String? name;
  String? message;
  String? time;
  String? image;
  String? messageType;
  ChatModel({
    this.id,
    this.name,
    this.message,
    this.time,
    this.image,
    this.messageType,
  });

  ChatModel.fromJson(Map json) {
    id = json["id"];
    name = json["name"];
    message = json["message"];
    time = json["time"];
    image = json["image"];
    messageType = json["message_type"];
  }
}




//  {
//     "id": 1,
//     "name": "Mohamed",
//     "message": "Hello from flutter",
//     "time": "11:55 PM",
//     "image":
//         "https://images.unsplash.com/photo-1682685790910-1f3e1b8c5d4?ixlib=rb-4.0",
//     "message_type": "text",
//   },
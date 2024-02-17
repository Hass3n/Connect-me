class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? Image;


  MessageModel(senderId, receiverId, dateTime, text,Image) {
    this.senderId = senderId;
    this.receiverId = receiverId;
    this.dateTime = dateTime;
    this.text = text;
    this.Image = Image;

  }

  // Named Constrcutor

  MessageModel.fromJson(Map<String, dynamic> ?json) {
    senderId = json!['senderId'];
    receiverId = json!['receiverId'];
    dateTime = json!['dateTime'];
    text = json!['text'];
    Image = json!['Image'];

  }

  Map<String, String> toMap() {
    return {
      'senderId': this.senderId.toString(),
      'receiverId': this.receiverId.toString(),
      'dateTime': this.dateTime.toString(),
      'text': this.text.toString(),
      'Image': this.Image.toString(),

    };
  }
}

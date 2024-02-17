class PostsModel {
  String? Name;
  String? Uid;
  String? Image;
  String? dateTime;
  String? Text;
  String? PostImage;


  PostsModel({Name, Uid,Image,dateTime,Text,PostImage}) {
    this.Name = Name;
    this.Uid = Uid;
    this.Image = Image;
    this.dateTime = dateTime;
    this.Text=Text;
    this.PostImage=PostImage;

  }

  // Named Constrcutor

  PostsModel.fromJson(Map<String, dynamic> ?json) {
    Name = json!['Name'];
    Uid = json!['Uid'];
    Image = json!['Image'];
    dateTime = json!['dateTime'];
    Text=json!['Text'];
    PostImage=json!['PostImage'];

  }

  Map<String, String> toMap() {
    return {
      'Name': this.Name.toString(),
      'Uid': this.Uid.toString(),
      'Image': this.Image.toString(),
      'dateTime': this.dateTime.toString(),
      'Text':this.Text.toString(),
      'PostImage':this.PostImage.toString(),

    };
  }
}

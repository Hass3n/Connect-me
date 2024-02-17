class UserModel {
  String? Name;
  String? Email;
  String? Phone;
  String? Password;
  String? isEmailverify;
  String? bio;
  String? Posts;
  String? followers;
  String? following;
  String? photos;
  String? coverimage;
  String? profileimage;
  String? Uid;
  String? token;


  UserModel(Name, Email, Phone, Password,isEmailverify,bio,Posts,followers,following,photos,coverimage,profileimage,Uid,token) {
    this.Name = Name;
    this.Email = Email;
    this.Phone = Phone;
    this.Password = Password;
    this.isEmailverify=isEmailverify;
    this.bio=bio;
    this.Posts=Posts;
    this.followers=followers;
    this.following=following;
    this.photos=photos;
    this.coverimage=coverimage;
    this.profileimage=profileimage;
    this.Uid=Uid;
    this.token=token;
  }

  // Named Constrcutor

  UserModel.fromJson(Map<String, dynamic> ?json) {
    Name = json!['Name'];
    Email = json!['Email'];
    Phone = json!['Phone'];
    Password = json!['Password'];
    isEmailverify=json!['isEmailverify'];
    bio=json!['bio'];
    Posts=json!['Posts'];
    followers=json!['followers'];
    following=json!['following'];
    photos=json!['photos'];
    coverimage=json!['coverimage'];
    profileimage=json!['profileimage'];
    Uid=json!['Uid'];
    token=json!['token'];
  }

  Map<String, String> toMap() {
    return {
      'Name': this.Name.toString(),
      'Email': this.Email.toString(),
      'Phone': this.Phone.toString(),
      'Password': this.Password.toString(),
      'isEmailverify':this.isEmailverify.toString(),
      'bio':this.bio.toString(),
      'Posts':this.Posts.toString(),
      'followers':this.followers.toString(),
      'following':this.following.toString(),
      'photos':this.photos.toString(),
      'coverimage':this.coverimage.toString(),
      'profileimage':this.profileimage.toString(),
      'Uid':this.Uid.toString(),
      'token':this.token.toString(),
    };
  }
}

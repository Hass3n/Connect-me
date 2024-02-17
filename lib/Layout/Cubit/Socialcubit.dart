
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/Layout/Cubit/socialstate.dart';
import 'package:socialapp/Models/Create_user.dart';
import 'package:socialapp/Models/Message_Model.dart';
import 'package:socialapp/Models/PostModel.dart';
import 'package:socialapp/Modules/Addpost/Addpost.dart';
import 'package:socialapp/Modules/Chat/Chat_screen.dart';
import 'package:socialapp/Modules/Feeds/Feeds_screen.dart';
import 'package:socialapp/Modules/Settings/Settings_dart.dart';
import 'package:socialapp/Modules/User/User_screen.dart';
import 'package:socialapp/Network/Local/Cache_helper.dart';
import 'package:socialapp/Shared/Constant.dart';

class SocilaCubit extends Cubit<SocialState> {
  SocilaCubit() : super(SocialIntialState());

  static SocilaCubit get(context) => BlocProvider.of(context);


  var bioControl = TextEditingController();
  var nameControl = TextEditingController();
  var phoneControl = TextEditingController();
  var messageControl = TextEditingController();
  String? token="";
  UserModel? model;
  Getuser() {
    emit(SocialloadGetuserState());
    FirebaseFirestore.instance
        .collection("User")
        .doc(CacheHelper.gettoken(key: "UID").toString())
        .get()
        .then((value) {
      print('sucess${value.id}');
      model = UserModel.fromJson(value.data()!);

      bioControl.text = model!.bio.toString();
      nameControl.text = model!.Name.toString();
      phoneControl.text = model!.Phone.toString();
      getAlluser();


      emit(SocialGetusersucess());
    }).catchError((error) {
      print('-----------${error.toString()}');
      emit(SocialGetuserError(error.toString()));
    });
  }

  void updateValue() {
    FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .update({'isEmailverify': "true"}).then((value) {
      Getuser();
      print('updated');
    }).catchError((error) {
      print('error updated');
    });
  }

  var current_index = 0;
  var screen = [
    Feeds(),
    Chat(),
    Settings_scrren(),
    Addpost(),
  ];

  var title = ["Home", "Chat", "Settings", 'Create post'];
  void ChnageBottoomIndex(index) {
    current_index = index;
    emit(ChangeIndex());
  }

  File? Profileimage;

  Future<void> pickprofileImage() async {
    final pickedfile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      Profileimage = File(pickedfile.path);

      emit(SocialPickeProfileImagesucess());

      print('image${Profileimage}');
    } else {
      emit(SocialPickeProfileImageError());
    }
  }

  File? Coverimage;

  Future<void> pickCoverImage() async {
    final pickedfile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      Coverimage = File(pickedfile.path);
      print('image${Coverimage}');
      emit(SocialPickeCoverImagesucess());
    } else {
      emit(SocialPickeCoverImageError());
    }
  }

  var ProfileUrlImage;
  void uploadprofileimage({Name, bio, phone}) {
    FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(Profileimage!.path).pathSegments.last}')
        .putFile(Profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialLoadprofileImagesucess());

        ProfileUrlImage = value;
        UpdateUserData(Name: Name, bio: bio, phone: phone);
        print('url${value}');
      }).catchError((error) {
        emit(SocialLoadprofileImageError());
      });
    }).catchError((error) {
      emit(SocialLoadprofileImageError());
    });
  }

  var CoverUrlImage;
  void uploadCoverimage({Name, bio, phone}) {
    FirebaseStorage.instance
        .ref()
        .child('user/${Uri.file(Coverimage!.path).pathSegments.last}')
        .putFile(Coverimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialLoadCoverImagesucess());

        CoverUrlImage = value;
        UpdateUserData(Name: Name, bio: bio, phone: phone);
        print('url${value}');
      }).catchError((error) {
        emit(SocialLoadCoverImageError());
      });
    }).catchError((error) {
      emit(SocialLoadCoverImageError());
    });
  }

  void Updateuserimages({Name, bio, phone}) {
    CoverUrlImage = null;
    ProfileUrlImage = null;
    emit(
        SocialLoadUpdateuerData()); // هنعمل Lineraprogress Indiactio  SocialLoadUpdateuerData when statis

    if (Profileimage != null && Coverimage != null) {
      uploadprofileimage(Name: Name, bio: bio, phone: phone);
      uploadCoverimage(Name: Name, bio: bio, phone: phone);
    } else if (Profileimage != null) {
      uploadprofileimage(Name: Name, bio: bio, phone: phone);
    } else if (Coverimage != null) {
      // upload coverimage

      uploadCoverimage(Name: Name, bio: bio, phone: phone);
    } else {
// upload Bio && Name && phone
      UpdateUserData(Name: Name, bio: bio, phone: phone);
    }
  }

  void UpdateUserData({Name, bio, phone}) {
    UserModel userModel = UserModel(
        Name,
        model?.Email,
        phone,
        model?.Password,
        model?.isEmailverify,
        bio,
        model?.Posts,
        model?.followers,
        model?.following,
        model?.photos,
        CoverUrlImage == null ? model?.coverimage : CoverUrlImage,
        ProfileUrlImage == null ? model?.profileimage : ProfileUrlImage,
        model?.Uid,token);

    FirebaseFirestore.instance
        .collection('User')
        .doc(CacheHelper.gettoken(key: "UID".toString()))

        .update(userModel.toMap())
        .then((value) {
      print('coverurl${CoverUrlImage}');
      Getuser();
    }).catchError((error) {
      emit(SocialLoadUpdateuerDataError());
    });
  }

  String itemvalue = '';
  void Chnageitemvalue(String val) {
    itemvalue = val;
    emit(SocialChangeData());
  }

  createPost(
      {required String datatime, required String text, String? postImage}) {
    emit(SocialLoadPost());

    PostsModel postsModel = PostsModel(
        Name: model?.Name,
        Uid: model?.Uid,
        Image: model?.profileimage,
        dateTime: datatime,
        Text: text,
        PostImage: postImage ?? '');
    FirebaseFirestore.instance
        .collection("Posts")
        .add(postsModel.toMap())
        .then((value) {
      emit(SocialLoadSucesspost());
    }).catchError((error) {
      emit(SocialLoaderrorpost());
    });
  }

  File? postimage;
  Future<void> pickpostImage() async {
    final pickedfile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      postimage = File(pickedfile.path);
      print('image${postimage}');
      uploadPostimage();
      emit(SocialLoadpickpostImagesucess());
    } else {
      emit(SocialLoadpickpostImageError());
    }
  }

  var PostUrlImage;
  void uploadPostimage() {
    FirebaseStorage.instance
        .ref()
        .child('Post/${Uri.file(postimage!.path).pathSegments.last}')
        .putFile(postimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(SocialLoadsucessImagepost());

        PostUrlImage = value;
      }).catchError((error) {
        emit(SocialLoaderrorImagepost());
      });
    }).catchError((error) {
      emit(SocialLoaderrorImagepost());
    });
  }

  void Removepostimage() {
    postimage = null;
    emit(SocialRemovepost());
  }

  List<PostsModel> post = [];
  List<String> postID = [];
  List<int>numlike=[];

/*  void getPosts() {
    FirebaseFirestore.instance
        .collection("Posts")
        .get()
        .then((value) {
          value.docs.forEach((element) {

            element.reference.collection('Likes').get().then((value) {
              print('Id${element.id}');
              print('lenght${value.docs.length}');

              numlike.add(value.docs.length);
              postID.add(element.id);
              post.add(PostsModel.fromJson(element.data()));


            });



            emit(SocialGetallpostsucess());
          });

    })
        .catchError((error) {
          emit(SocialGetAlleposterror());
    });
  }*/

  void getAllposts()
  {
    FirebaseFirestore.instance
        .collection("Posts")
        .snapshots()
        .listen((event) {
          numlike=[];
          postID=[];
          post=[];
        event.docs.forEach((element) {
          element.reference.collection('Likes').get().then((value) {
            print('Id${element.id}');
            print('lenght${value.docs.length}');

            numlike.add(value.docs.length);
            postID.add(element.id);
            post.add(PostsModel.fromJson(element.data()));


          });

          emit(SocialGetallpostsucess());

        });

    });

  }
  void likePost(String postId)
  {
    FirebaseFirestore.instance.collection('Posts')
        .doc(postId)
        .collection('Likes')
        .doc(model!.Uid)
        .set({
        'Like':true
    }).then((value) {
      Ischangelike();
      emit(SocialLikepostsucess());

    }).catchError((error){

      emit(SocialLikeposterror());

    });


  }

  bool isliked=false;

  void Ischangelike()
  {
    isliked=!isliked;

    emit(SocialChangelikeState());


  }
  
  List<UserModel>user=[];
  
  void getAlluser()
  {
    FirebaseFirestore.instance
        .collection("User")
        .get()
        .then((value) {
      value.docs.forEach((element) {

           if(element.data()['Uid']!=model!.Uid) {
             user.add(UserModel.fromJson(element.data()));

             getmessage( recieverId:element.data()['Uid']);
             getunreadmessages(recieverId:element.data()['Uid'] );
           }

    



        emit(SocialloadSucessuser());
      });

    })
        .catchError((error) {
      emit(Socialloaderrorsuser());
    });
  }


  List<MessageModel>unreadmessages=[ ];
  void sendMessage({required String recieverId,required String dateTime,required  String text,required  String image})
  {
    MessageModel messageModel=MessageModel(model!.Uid, recieverId, dateTime, text,image);

    // set My chat
    FirebaseFirestore.instance.collection('User')
    .doc(model!.Uid)
    .collection('Chats')
    .doc(recieverId)
    .collection('messages')
    .add(messageModel.toMap())
    .then((value) {
      emit(SocialSendMessageSucessState());
    })
    .catchError((error){
      emit(SocialSendMessageErrorState());
    });


    // set Reciever chat
    FirebaseFirestore.instance.collection('User')
        .doc(recieverId)
        .collection('Chats')
        .doc(model!.Uid)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {






      emit(SocialSendMessageSucessState());
    })
        .catchError((error){
      emit(SocialSendMessageErrorState());
    });


    unreadmessages=[];

    // get field online state

    FirebaseFirestore.instance
        .collection("User")
         .doc(recieverId)
         .get()
         .then((value) {

           print('--------online-${value.data()!['online']}');
           // unreead message

           if(!value.data()?['online']) {
             unreadmessages.add(messageModel);
             for (int i = 0; i < unreadmessages.length; i++) {
               FirebaseFirestore.instance.collection('User')
                   .doc(recieverId)
                   .collection('Chats')
                   .doc(model!.Uid)
                   .collection('unread')
                   .add(unreadmessages[i].toMap())
                   .then((value) {
                 emit(SocialSendUnreadMessageSucessState());
               }).catchError((error) {
                 emit(SocialSendUnreadMessageErrorState());
               });
             }
           }

       });


//https://www.youtube.com/watch?v=fMh5ECuGSR8


  }

  List<MessageModel>messages=[];

  void getmessage({required String recieverId})
  {

    FirebaseFirestore.instance.collection('User')
        .doc(model!.Uid)
        .collection('Chats')
        .doc(recieverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {

         messages=[];// Not duuplicated;
          event.docs.forEach((element) {
            messages.add(MessageModel.fromJson(element.data()));

          });

          emit(SocialGetMessageSucessState());

    });
  }


  List<MessageModel> countunreadmessages=[];
  void getunreadmessages({required String recieverId})
  {
    FirebaseFirestore.instance.collection('User')
        .doc(model!.Uid)
        .collection('Chats')
        .doc(recieverId)
        .collection('unread')
         .orderBy('dateTime')
        .snapshots()
        .listen((event) {

      countunreadmessages=[];
      if(event.docs.isEmpty)
      {

        print('-------------empty');
       }
      else {
        event.docs.forEach((element) {
          countunreadmessages.add(MessageModel.fromJson(element.data()));
          print('----------------${countunreadmessages.length}');
          print('----------${element.data()}');
        });

        emit(SocialGetUnreadMessageSucessState());

      }

    });




  }

  void deleteunreadmessages({required String recieverId})
  {
    FirebaseFirestore.instance.collection('User')
        .doc(model!.Uid)
        .collection('Chats')
        .doc(recieverId)
        .collection('unread')

        .get()
        .then((value) {

      for(DocumentSnapshot ds in value.docs)
      {
        ds.reference.delete();
      }

      emit(SocialDeleteUnreadMessageSucessState());
    })
        .catchError((error){
      emit(SocialDeleteUnreadMessageErrorState());

    });
  }

  // update online state
  void updateStatechat({required bool Isonlinestate})
  {
    FirebaseFirestore.instance
        .collection('User')
        .doc(CacheHelper.gettoken(key: "UID".toString()))

        .update({'online':Isonlinestate})
        .then((value) {


          emit(SocialUpdateChatsucessState());

    }).catchError((error) {

      emit(SocialUpdateChatErrorState());

    });
  }

  // pick chat images

  File? Chatimage;

  Future<void> pickChatImage({required String recievertoken,required String recieverName,required String recieverId,required String dateTime}) async {
    final pickedfile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedfile != null) {
      Chatimage = File(pickedfile.path);
      uploadchatimage(recievertoken,recieverName,  Chatimage,recieverId,dateTime);
      emit(SocialLoadpickchatImagesucess());

      print('image${Chatimage}');
    } else {
      emit(SocialLoadpickchatImageError());
    }
  }
  var chatUrlImage;
  void uploadchatimage(String recievertoken, String recieverName,Chatimage, String recieverId, String dateTime) {
    FirebaseStorage.instance
        .ref()
        .child('chat/${Uri.file(Chatimage!.path).pathSegments.last}')
        .putFile(Chatimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {

        chatUrlImage = value;

        if(value!=null) {
          sendMessage(recieverId: recieverId,
              dateTime: dateTime,
              text: "",
              image: value);

          sendAndRetrieveMessage(recieverName, "send photo", recievertoken);
        }
        print('chatUrlImage${value}');

       // emit(SocialLoadchatImagesucess());

      }).catchError((error) {
        emit(SocialLoadchatImageError());
      });
    }).catchError((error) {
      emit(SocialLoadchatImageError());
    });
  }

  void updatetokenuser() async
  {
     token= await FirebaseMessaging.instance.getToken();

    print('--------------------token ${token}');
    FirebaseFirestore.instance
        .collection('User')
        .doc(CacheHelper.gettoken(key: "UID".toString()))

        .update({'token':token})
        .then((value) {


      emit(Socialupdatetokensucess());

    }).catchError((error) {

      emit(SocialupdatetokenError());

    });
  }
}

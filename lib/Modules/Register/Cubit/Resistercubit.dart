
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Models/Create_user.dart';
import 'package:socialapp/Modules/Register/Cubit/Registerstate.dart';

class RegisterCubit extends Cubit<RegisterState>
{

  RegisterCubit():super(RegisterIntialState());

  static RegisterCubit  get(context)=>BlocProvider.of(context);





  userRegister({ required String name,required String phone,  required String email,required String password,required String image})
  {


    emit(RegisterloadState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {

          CreateUser(name: name, phone: phone, email: email, password: password, uid: value.user!.uid.toString(),isverfifyemail: "false");
          //emit(RegistersucessState());
    })
    .catchError((error){

      print('error${error.toString()}');
      emit(Registererrorstate(error.toString()));
    });





  }

  CreateUser({  required String name,required String phone,  required String email,required String password,required String uid,required String isverfifyemail})
  {
   UserModel userModel=UserModel(name, email, phone, password,isverfifyemail,"","","","","","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTExtoLVhMIfPRj_8d5RQKF2qjwUbuYL2tZTg&usqp=CAU","https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTExtoLVhMIfPRj_8d5RQKF2qjwUbuYL2tZTg&usqp=CAU",uid,"");


     FirebaseFirestore.instance.collection("User").doc(uid).set(
       userModel.toMap()
     ).then((value) {
       emit(CreateUsersucessState());
     }).catchError((error){
       emit(CreateUsererrorstate(error));
     });






  }

  bool isSecure=true;
  void ChangeIcoState()
  {

    isSecure=!isSecure;

    emit(ChangeIconstate());

  }

}
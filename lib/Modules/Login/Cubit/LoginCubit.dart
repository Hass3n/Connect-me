

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Modules/Login/Cubit/Loginstate.dart';


class LoginCubit extends Cubit<LoginState>
{

  LoginCubit():super(LoginIntialState());

  static LoginCubit  get(context)=>BlocProvider.of(context);





 userlogin({required String email,required String password})
  {

    emit(LoginloadState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
    .then((value) {
      emit(LoginsucessState(uId: value.user!.uid));

    }).catchError((error){
      emit(Loginerrorstate(error.toString()));

    });


  }
  bool isSecure=true;
  void ChangeIcoState()
  {

    isSecure=!isSecure;

    emit(ChangeIconstate());

  }

}
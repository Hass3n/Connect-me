
abstract class  LoginState {}

class LoginIntialState extends LoginState{}
class LoginloadState extends LoginState{}
class LoginsucessState extends LoginState{

  final String uId;
  LoginsucessState({ required this.uId});


}
class Loginerrorstate extends LoginState{
  final String error;

  Loginerrorstate(this.error);

}

class ChangeIconstate extends LoginState{}

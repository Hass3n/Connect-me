

abstract class  RegisterState {}
class RegisterIntialState extends RegisterState{}
class RegisterloadState extends RegisterState{}
class RegistersucessState extends RegisterState{
}
class Registererrorstate extends RegisterState{
  final String error;
  Registererrorstate(this.error);

}
class CreateUsersucessState extends RegisterState{



}
class CreateUsererrorstate extends RegisterState{
  final String error;

  CreateUsererrorstate(this.error);

}
class ChangeIconstate extends RegisterState{}


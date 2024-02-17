import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Social_layout.dart';
import 'package:socialapp/Modules/Login/Cubit/LoginCubit.dart';
import 'package:socialapp/Modules/Login/Cubit/Loginstate.dart';
import 'package:socialapp/Modules/Register/Register.dart';
import 'package:socialapp/Network/Local/Cache_helper.dart';
import 'package:socialapp/Shared/Components.dart';
import 'package:socialapp/Shared/Constant.dart';


class SocialLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var emailControl=TextEditingController();
    var passwordControl=TextEditingController();
    var _keyform=GlobalKey<FormState>();

    return BlocProvider(create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(builder: (context,state){
        return    Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _keyform,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',style: Theme.of(context).textTheme.headline5!.copyWith(color: defaultcolor)),
                      SizedBox(height: 10.0,),

                      Text('Login now to brows our hot offer',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey)),
                      SizedBox(height: 30.0,),

                      defaultFormfield(
                        Control: emailControl,
                        labeltext: "Email Address",
                        prefixicon: Icons.email_outlined,
                        type: TextInputType.text,
                        validate:( val)
                        {

                          if(val!.isEmpty)
                          {
                            return 'you must write Email Address';
                          }

                          return null;

                        },

                      ),

                      SizedBox(height: 20.0,),
                      defaultFormfield(
                        Control: passwordControl,
                        labeltext: "Password",
                        isSecure:LoginCubit.get(context).isSecure,
                        prefixicon: Icons.lock_outline,
                        suffixicon:LoginCubit.get(context).isSecure? Icons.visibility_off:Icons.visibility,
                        suffixpress: (){

                          LoginCubit.get(context).ChangeIcoState();
                        },
                        type: TextInputType.text,
                        validate:( val)
                        {

                          if(val!.isEmpty)
                          {
                            return 'you must write Email Address';
                          }

                          return null;

                        },


                      ),

                      SizedBox(height: 20.0,),

                      ConditionalBuilder(
                        condition: state is ! LoginloadState,
                        builder: (context)=>defaultButton(context: context,onpress: (){


                          if(_keyform.currentState!.validate())
                          {

                           LoginCubit.get(context).userlogin(email: emailControl.text, password: passwordControl.text);

                          }



                        },text: "LOGIN"),
                        fallback: (context)=>Center(child: CircularProgressIndicator()),


                      ),


                      SizedBox(height: 20.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have account ?'),
                          SizedBox(width: 5.0,),
                          defaultTextbutton(onpress: (){

                            NavigateTo(context: context,screen: Registerscreen());



                          },txt: "Register now")
                        ],
                      ),



                    ],
                  ),
                ),
              ),
            ),
          ),


        );


      }, listener: (context,state){

       if(state is LoginsucessState)
        {


            ShowToast(text: "sucess",state: Toaststate.SUCESS);
            print("id${state.uId}");

          CacheHelper.saveData(key: "UID", value: state.uId).then((value) {
              if(value) {


                Navigateandremove(screen: SocialLayout(), context: context);



              }

            });



          }


          else if(state is Loginerrorstate)
          {
            ShowToast(text: state.error.toString(),state: Toaststate.ERROR);



          }









      }),



    );


  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Social_layout.dart';
import 'package:socialapp/Modules/Login/Login_screen.dart';
import 'package:socialapp/Modules/Register/Cubit/Registerstate.dart';
import 'package:socialapp/Modules/Register/Cubit/Resistercubit.dart';
import 'package:socialapp/Shared/Components.dart';
import 'package:socialapp/Shared/Constant.dart';

class Registerscreen extends StatelessWidget {
  const Registerscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailControl=TextEditingController();
    var nameControl=TextEditingController();
    var phoneControl=TextEditingController();
    var passwordControl=TextEditingController();
    var _keyform=GlobalKey<FormState>();

    return BlocProvider(create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(builder: (context,state){
        return    Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _keyform,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Register',style: Theme.of(context).textTheme.headline5!.copyWith(color: defaultcolor)),
                      SizedBox(height: 10.0,),

                      Text('Register now to commnucation to other friends',style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey)),
                      SizedBox(height: 30.0,),
                      defaultFormfield(
                        Control: nameControl,
                        labeltext: "Name",
                        prefixicon: Icons.person,
                        type: TextInputType.text,
                        validate:( val)
                        {

                          if(val!.isEmpty)
                          {
                            return 'you must write Your Name';
                          }

                          return null;

                        },

                      ),

                      SizedBox(height: 20.0,),
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
                        Control: phoneControl,
                        labeltext: "phone",
                        prefixicon: Icons.phone,
                        type: TextInputType.number,
                        validate:( val)
                        {

                          if(val!.isEmpty)
                          {
                            return 'you must write your phone';
                          }

                          return null;

                        },

                      ),

                      SizedBox(height: 20.0,),
                      defaultFormfield(
                        Control: passwordControl,
                        labeltext: "Password",
                        isSecure:RegisterCubit.get(context).isSecure,
                        prefixicon: Icons.lock_outline,
                        suffixicon:RegisterCubit.get(context).isSecure? Icons.visibility_off:Icons.visibility,
                        suffixpress: (){

                          RegisterCubit.get(context).ChangeIcoState();
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
                        condition: state is ! RegisterloadState,
                        builder: (context)=>defaultButton(context: context,onpress: (){


                          if(_keyform.currentState!.validate())
                          {

                           RegisterCubit.get(context).userRegister(name:
                            nameControl.text, phone: phoneControl.text, email: emailControl.text,
                                password: passwordControl.text, image: "");

                          }



                        },text: "Sign Up"),
                        fallback: (context)=>Center(child: CircularProgressIndicator()),


                      ),


                      SizedBox(height: 20.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have account ?'),
                          SizedBox(width: 5.0,),
                          defaultTextbutton(onpress: (){

                            NavigateTo(context: context,screen: SocialLogin());


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

        if(state is CreateUsersucessState)
        {

          Navigateandremove(screen: SocialLayout(),context: context);

        }



      }),



    );
  }
}

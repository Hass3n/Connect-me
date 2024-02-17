
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:socialapp/Layout/Cubit/Socialcubit.dart';
import 'package:socialapp/Layout/Cubit/socialstate.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocilaCubit,SocialState>(
      builder: (context,state)
      {
        var model=SocilaCubit.get(context).model;

        return Scaffold(
          backgroundColor: Colors.white,



          body:SocilaCubit.get(context).screen[SocilaCubit.get(context).current_index],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: SocilaCubit.get(context).current_index,

            onTap: (index)
            {
                SocilaCubit.get(context).ChnageBottoomIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                  label: "Chats",
                  icon: FaIcon(FontAwesomeIcons.solidComment)
              ),

              
              BottomNavigationBarItem(icon: Icon(Icons.ac_unit_sharp),
                label: "Settings"

              ) , BottomNavigationBarItem(icon: Icon(Icons.add_box_rounded),
                label: "Add Post"

              )

            ],
        ),
        );
      },
      listener: (context,state)
      {

      },
    );
  }
}
/*
*
* ConditionalBuilder(
              condition: model!=null

              , builder: (context){
                return Column(
                  children: [

                    if(model?.isEmailverify!="true")
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),

                      child: Container(
                        color: Colors.amber.withOpacity(.6),
                        child: Row(children: [
                          Icon(Icons.info_outline,size: 30.0,),
                          SizedBox(width: 5.0,),
                          Text('Please verify your email',style: TextStyle(fontSize: 15.0),),
                          Spacer(),
                          defaultTextbutton(onpress: (){

                            FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {

                              SocilaCubit.get(context).updateValue();
                              print('the emil  varfication');
                            }).catchError((error){

                              print('the emil  error');


                            });


                          },txt: "Send",size: 15.0)

                        ],),
                      ),
                    ),
                  ],
                );
          }, fallback: (context)=>Center(child: CircularProgressIndicator())),
*
*
* */
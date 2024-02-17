import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/Socialcubit.dart';
import 'package:socialapp/Layout/Cubit/socialstate.dart';
import 'package:socialapp/Modules/Editprofile/Editprofile.dart';
import 'package:socialapp/Shared/Constant.dart';
class Settings_scrren extends StatelessWidget {
  const Settings_scrren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocilaCubit,SocialState>(
        builder: (context,state){
          var user_model=SocilaCubit.get(context).model;
          print('covervalue${user_model?.coverimage}');
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                title: Text( SocilaCubit.get(context).title[SocilaCubit.get(context).current_index],style:  Theme.of(context).textTheme.headline6),
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.notification_add_outlined)),

                ],
                elevation: 0.0,
                toolbarHeight: 80,

              ),
            body:
           Padding(
            padding:  EdgeInsets.all(8.0),
            child: Column(

              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  clipBehavior: Clip.none,
                  children: [

                    Positioned(
                      child: Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height/3,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image:  DecorationImage(image:
                                user_model!.coverimage!.isEmpty?
                                    NetworkImage('$defaultCoverimage'):
                                    NetworkImage('${user_model?.coverimage}')
                                
                            ,fit: BoxFit.cover),


                          )
                      ),
                    ),
                    Positioned(
                        right: 5.0,
                        bottom: -50,

                        child:    CircleAvatar(
                          backgroundImage:   user_model!.profileimage!.isEmpty?
                          NetworkImage('$defaultCoverimage'):
                          NetworkImage('${user_model?.profileimage}'



                          ),
                          radius: 60.0,
                        )),

                    Positioned(
                      bottom: -40,
                      right: 5,
                      child: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          radius: 15.0,
                          child: IconButton(onPressed: (){},icon: Icon(Icons.camera_alt_outlined,size: 20.0,),)

                      ),
                    ),
                    Positioned(
                      bottom: -75,
                      right:20,
                      child: Text('${user_model?.Name}',style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                    ),

                  ],),

                SizedBox(height: 100.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user_model?.bio}',style: TextStyle(fontSize: 15.0,color: Colors.grey),),

                    SizedBox(height: 20.0,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: (){},
                                child: Column(
                                  children: [
                                    Text('22',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: defaultcolor),),
                                    SizedBox(height: 5.0,),

                                    Text('Posts',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0,color: defaultcolor),)
                                  ],),
                              ),
                            ),    Expanded(
                              child: InkWell(
                                onTap: (){},
                                child: Column(
                                  children: [
                                    Text('50',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: defaultcolor),),
                                    SizedBox(height: 5.0,),

                                    Text('Photos',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0,color: defaultcolor),)
                                  ],),
                              ),
                            ),    Expanded(
                              child: InkWell(
                                onTap: (){},
                                child: Column(
                                  children: [
                                    Text('100k',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: defaultcolor),),
                                    SizedBox(height: 5.0,),

                                    Text('Followers',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0,color: defaultcolor),)
                                  ],),
                              ),
                            ),    Expanded(
                              child: InkWell(
                                onTap: (){},
                                child: Column(
                                  children: [
                                    Text('33',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: defaultcolor),),
                                    SizedBox(height: 5.0,),

                                    Text('Following',style:Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0,color: defaultcolor),)

                                  ],),
                              ),
                            ),


                          ],),
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Row(

                      children: [
                        Expanded(
                          child: OutlinedButton(

                              style:  ButtonStyle(),
                              onPressed: (){

                              },
                              child: Text('Add Story')),
                        ),

                        SizedBox(width: 10.0,),
                        OutlinedButton(onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Editprofile()) );

                        }, child: Icon(Icons.edit)),
                      ],)
                  ],)

              ],
            ),

          ));
        }, listener: (context,state){

    });
  }
}

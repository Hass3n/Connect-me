import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/Socialcubit.dart';
import 'package:socialapp/Layout/Cubit/socialstate.dart';
import 'package:socialapp/Shared/Components.dart';
import 'package:socialapp/Shared/Constant.dart';
import 'package:socialapp/Shared/Permission.dart';

class Editprofile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<SocilaCubit, SocialState>(

        builder: (context, state) {
          var user_model=SocilaCubit.get(context).model;

          return Scaffold(

              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(50.0),
                  child: defaultAppBar(
                      context: context,
                      title: 'Edit profile',
                      action: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: defaultTextbutton(
                              onpress: () {
                                SocilaCubit.get(context).Updateuserimages(
                                    Name: SocilaCubit.get(context).nameControl.text,
                                    bio:SocilaCubit.get(context).bioControl.text,
                                    phone: SocilaCubit.get(context).phoneControl.text);
                              },
                              txt: 'Update',
                              size: 15.0,
                              fontWeight: FontWeight.bold),
                        )
                      ])),
              body: Padding(
                padding: const EdgeInsets.all(5.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if(state is SocialLoadUpdateuerData )
                          LinearProgressIndicator(),
                      if(state is SocialLoadUpdateuerData )
                           SizedBox(height: 10.0,),
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height / 4.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5.0),
                                        topLeft: Radius.circular(5.0)),
                                    image: DecorationImage(
                                        image:
                                        SocilaCubit.get(context).Coverimage == null
                                            ? NetworkImage(
                                            SocilaCubit.get(context).model!.coverimage.toString())
                                            : FileImage(SocilaCubit.get(context).Coverimage!!)
                                        as ImageProvider,
                                        fit: BoxFit.cover),
                                  )),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                    radius: 20.0,
                                    child: IconButton(
                                        onPressed: () {
                                          SocilaCubit.get(context).pickCoverImage();
                                          SocilaCubit.get(context).Chnageitemvalue('cover');


                                        },
                                        icon: Icon(Icons.camera_alt_outlined))),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                              ),
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                radius: 64.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    backgroundImage: SocilaCubit.get(context).Profileimage == null
                                        ? NetworkImage(
                                        SocilaCubit.get(context).model!.profileimage.toString())
                                        : FileImage(SocilaCubit.get(context).Profileimage!!)
                                            as ImageProvider,
                                    radius: 60.0,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                  radius: 20.0,
                                  child: IconButton(
                                    onPressed: () async {

                                        SocilaCubit.get(context)
                                            .pickprofileImage();

                                        SocilaCubit.get(context).Chnageitemvalue('profile');

                                    },
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 20,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormfield(
                        Control: SocilaCubit.get(context).nameControl,
                        labeltext: "Name",
                        prefixicon: Icons.person,
                        type: TextInputType.text,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'you must write Your Name';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      defaultFormfield(
                        Control: SocilaCubit.get(context).bioControl,
                        labeltext: "Bio",
                        prefixicon: Icons.ac_unit_rounded,
                        type: TextInputType.text,

                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'you must write Your Bio';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormfield(
                        Control: SocilaCubit.get(context).phoneControl,
                        labeltext: "Phone",
                        prefixicon: Icons.phone,
                        type: TextInputType.text,
                        validate: (val) {
                          if (val!.isEmpty) {
                            return 'you must write Your Phone';
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 50.0,),
                    ],
                  ),
                ),
              ));
        },
        listener: (context, state) {

          print('state is :${state.toString()}');
        });
  }
}

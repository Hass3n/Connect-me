import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/Socialcubit.dart';
import 'package:socialapp/Layout/Cubit/socialstate.dart';
import 'package:socialapp/Models/Create_user.dart';
import 'package:socialapp/Shared/Constant.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ChatDetailsScreen({required this.userModel});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocilaCubit.get(context).getmessage(recieverId: userModel.Uid.toString());
      SocilaCubit.get(context).deleteunreadmessages(recieverId: userModel.Uid.toString());
      SocilaCubit.get(context).updateStatechat(Isonlinestate: true);
      return BlocConsumer<SocilaCubit, SocialState>(
          builder: (context, state) {
            return WillPopScope(

                child:Scaffold(
                    appBar: AppBar(

                      titleSpacing: 0.0,
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 20.0,
                            backgroundImage:
                            NetworkImage('${userModel.profileimage}'),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            '${userModel.Name}',
                            style: TextStyle(letterSpacing: 1),
                          ),
                        ],
                      ),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(

                        children: [
                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  if (SocilaCubit.get(context).model!.Uid ==
                                       SocilaCubit.get(context)
                                          .messages[index]
                                          .senderId) {
                                    return bulildmymessage(SocilaCubit
                                        .get(context)
                                        .messages[index]
                                        .text, SocilaCubit
                                        .get(context)
                                        .messages[index]
                                        .Image!);
                                  }

                                  else {
                                    return bulidmessage(SocilaCubit
                                        .get(context)
                                        .messages[index]
                                        .text!, SocilaCubit
                                        .get(context)
                                        .messages[index]
                                        .Image!);
                                  }
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                  height: 15.0,
                                ),
                                itemCount:
                                SocilaCubit.get(context).messages.length),
                          ),
                          SizedBox(height: 15,),
                          Container(

                            decoration: BoxDecoration(

                                border: Border.all(
                                    color: Colors.grey.withOpacity(.2), width: 1.0),
                                borderRadius: BorderRadius.circular(15.0)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextFormField(
                                      controller:
                                      SocilaCubit.get(context).messageControl,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Type your message here ....'),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: 50,
                                    color: defaultcolor,
                                    child: MaterialButton(
                                      minWidth: 1,
                                      onPressed: () {
                                        SocilaCubit.get(context).sendMessage(
                                            recieverId: userModel.Uid.toString(),
                                            dateTime: DateTime.now().toString(),
                                            text: SocilaCubit.get(context)
                                                .messageControl
                                                .text,image: "");

                                        print('token---------------${userModel.token.toString()}');
                                        sendAndRetrieveMessage(userModel.Name.toString(), SocilaCubit.get(context)
                                            .messageControl
                                            .text, userModel.token.toString());
                                      },
                                      child: Icon(
                                        Icons.send,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    )),
                                SizedBox(width: 10.0,),
                                Container(
                                    height: 50,
                                    color: defaultcolor,
                                    child: MaterialButton(
                                      minWidth: 1,
                                      onPressed: () {


                                        // upload images

                                        SocilaCubit.get(context).pickChatImage(

                                            recievertoken: userModel.token.toString(),
                                            recieverName: userModel.Name.toString(),
                                            recieverId: userModel.Uid.toString(),
                                            dateTime: DateTime.now().toString(),


                                        );

                                      },
                                      child: Icon(
                                        Icons.document_scanner_outlined,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            ),
                          ),

                        ],
                      ),
                    )
                ),



                onWillPop: () async{
                  SocilaCubit.get(context).updateStatechat(Isonlinestate: false);

                  return true;

            });
          },
          listener: (context, state) {});
    });
  }

}

Widget bulidmessage( String message, String image) {


   if(image!="") {
     return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          width: 100,
          height: 200,
         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
         decoration: BoxDecoration(
             borderRadius: const BorderRadiusDirectional.only(
               bottomEnd: Radius.circular(10),
               topEnd: Radius.circular(10.0),
               topStart: Radius.circular(10.0),
             ),
             color: Colors.grey[300]),
            child:Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(image))
            ),
         ),
       ),
       );
      }
   return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(

        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
            color: Colors.grey[300]),
        child: Text(
          message,
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
        ),
      ),
    );

}

Widget bulildmymessage(message,image) {
  if(image!="") {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
            ),
            color: defaultcolor.withOpacity(.3)),
        child:Container(
          width: 100,
          height: 200,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(image))
          ),
        ),
      ),
    );
  }
  return Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
          ),
          color: defaultcolor.withOpacity(.3)),
      child: Text(
        message,
        style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 1),
      ),
    ),
  );
}

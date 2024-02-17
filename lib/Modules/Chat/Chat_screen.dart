import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/Socialcubit.dart';
import 'package:socialapp/Layout/Cubit/socialstate.dart';
import 'package:socialapp/Models/Create_user.dart';
import 'package:socialapp/Models/Message_Model.dart';
import 'package:socialapp/Modules/chat_details/ChatDetailsScreen.dart';
import 'package:socialapp/Shared/Components.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocilaCubit, SocialState>(
        builder: (context, state) => ConditionalBuilder(
              condition: SocilaCubit.get(context).user.length > 0,
              builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildChatitem(
                      SocilaCubit.get(context).user[index],
                      context,
                      SocilaCubit.get(context).countunreadmessages.length,
                      SocilaCubit.get(context).countunreadmessages.length > 0
                          ? SocilaCubit.get(context).countunreadmessages[
                              SocilaCubit.get(context)
                                      .countunreadmessages
                                      .length -
                                  1]
                          : SocilaCubit.get(context).messages.length>0?SocilaCubit.get(context).messages[SocilaCubit.get(context).messages.length-1]
                          :MessageModel("", "", "", "default messages","")),
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.withOpacity(.2),
                        ),
                      ),
                  itemCount: SocilaCubit.get(context).user.length),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
        listener: (context, state) {});
  }
}

Widget buildChatitem(
    UserModel model, context,  count, MessageModel messageModel) {
  return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(

        children: [
          SizedBox(height: 30.0,),
          InkWell(
            onTap: () {
              NavigateTo(
                  context: context,
                  screen: ChatDetailsScreen(
                    userModel: model,
                  ));
            },
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              CircleAvatar(
                backgroundImage: NetworkImage(model.profileimage.toString()),
                radius: 25.0,
              ),
              SizedBox(
                width: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.Name.toString(),
                        style: TextStyle(height: 1.4, fontWeight: FontWeight.w600),
                      ),
                  messageModel.senderId == model.Uid?
                            Text(
                              messageModel.text.toString(),
                              style: TextStyle(
                              height: 1.4,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueAccent),
                              ):
                      Text(
                        messageModel.text.toString(),
                        style: TextStyle(
                            height: 1.4,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1,
                            color: Colors.blueAccent),
                      ),
                    ],
                  ),
                  SizedBox(width: 100,),
                  if (count>0)
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Text(
                          '${count}',
                          style: TextStyle(
                              height: 1.4,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ]),
          ),
        ],
      ));
}

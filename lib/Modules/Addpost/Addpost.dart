import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/Socialcubit.dart';
import 'package:socialapp/Layout/Cubit/socialstate.dart';
import 'package:socialapp/Shared/Components.dart';
class Addpost extends StatelessWidget {
  const Addpost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocilaCubit,SocialState>(
        builder: (context,state){

          var user_model=SocilaCubit.get(context).model;
          var txt_control=TextEditingController();
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: defaultAppBar(
                context: context,
                title: 'Create Post',
                action: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: defaultTextbutton(
                        onpress: () {
                          if(SocilaCubit.get(context).PostUrlImage!=null)
                            {
                              SocilaCubit.get(context).createPost(datatime: DateTime.now().toString(), text: txt_control.text,postImage: SocilaCubit.get(context).PostUrlImage);

                            }

                         else
                          {
                            SocilaCubit.get(context).createPost(datatime: DateTime.now().toString(), text: txt_control.text);

                          }

                        },
                        txt: 'Post',
                        size: 15.0,
                        fontWeight: FontWeight.bold),
                  )
                ])),

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [

            if(state is SocialLoadPost)
               LinearProgressIndicator(),
            if(state is SocialLoadPost)
                SizedBox(height: 5.0,),

          Row(
              children:  [
                CircleAvatar(

                  backgroundImage: NetworkImage('${user_model?.profileimage}'),
                  radius: 25.0,
                ),
                SizedBox(width: 10.0,),
                Text('${user_model!.Name}',style: TextStyle(height: 1.4),),


              ],),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'what is on your mind......',
                  hintStyle: TextStyle(fontSize: 14.0,color: Colors.grey),
                  border: InputBorder.none
                ),
                controller: txt_control,
              ),
            ),
           if(SocilaCubit.get(context).postimage!=null)
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


                          FileImage(SocilaCubit.get(context).postimage!!)as ImageProvider,
                          fit: BoxFit.cover),
                    )),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                      radius: 20.0,
                      child: IconButton(
                          onPressed: () {


                            SocilaCubit.get(context).Removepostimage();
                          },
                          icon: Icon(Icons.cancel))),
                ),
                SizedBox(
                  height:
                  MediaQuery.of(context).size.height / 3.5,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(onPressed: (){

                    SocilaCubit.get(context).pickpostImage();
                  }, child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                    Icon(Icons.image,size: 35.0,),
                    SizedBox(width: 5.0,),
                    Text('Add photo')


                  ],)),
                ),
                Expanded(
                  child: TextButton(onPressed: (){}, child: Text('# tags')),
                ),
              ],
            ),

          ],),
        ),

      );


    }, listener: (context,state){});
  }
}

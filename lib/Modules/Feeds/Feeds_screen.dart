import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Layout/Cubit/Socialcubit.dart';
import 'package:socialapp/Layout/Cubit/socialstate.dart';
import 'package:socialapp/Models/Create_user.dart';
import 'package:socialapp/Models/PostModel.dart';
import 'package:socialapp/Shared/Constant.dart';
class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocilaCubit,SocialState>(

        builder: (context,state){
          var modeluser= SocilaCubit.get(context).model;



      return Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text( SocilaCubit.get(context).title[SocilaCubit.get(context).current_index],style:  Theme.of(context).textTheme.headline6),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.search)),
              IconButton(onPressed: (){}, icon: Icon(Icons.notification_add_outlined)),

            ],
            elevation: 0.0,
            toolbarHeight: 80,

          ),
        body: ConditionalBuilder(condition: SocilaCubit.get(context).post.length>0,


            builder: (context)=>SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                      clipBehavior:Clip.antiAliasWithSaveLayer,
                      margin: EdgeInsets.all(10.0),
                      elevation: 10.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          const Image(image:
                          NetworkImage('https://img.freepik.com/free-photo/tall-lighthouse-north-sea-cloudy-sky_181624-49637.jpg?size=626&ext=jpg'),
                            height: 200.0,
                            width: double.infinity,
                            fit: BoxFit.cover,

                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Communicate with friends",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                  color: Colors.white
                              ),


                            ),
                          ),
                        ],
                      )
                  ),

                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index){

                        return PostItem(context,SocilaCubit.get(context).post[index],modeluser!,index);

                      }, separatorBuilder: (context,index){
                    return SizedBox(height: 2.0,);
                  }, itemCount: SocilaCubit.get(context).post.length)


                ],
              ),
            ), fallback: (context)=>Center(child: CircularProgressIndicator()))
      );

    }, listener: (context,state){});
  }
}

Widget PostItem(context,PostsModel postsModel,var userModel, index)
{
  return    Card(
    clipBehavior:Clip.antiAliasWithSaveLayer,
    margin: EdgeInsets.all(10.0),
    elevation: 10.0,
    child: Padding(
      padding:  EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.all(10.0),
            child: Row(
              children: [
                 CircleAvatar(

                  backgroundImage: NetworkImage('${postsModel.Image}'),
                  radius: 25.0,
                ),
                SizedBox(width: 10.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children:  [
                        Text('${postsModel.Name}',style: TextStyle(height: 1.4),),
                        SizedBox(width: 15.0,),
                        const Icon(Icons.verified,
                          color: Colors.blue,
                          size: 20.0,

                        )
                      ],
                    ),
                    Text('${postsModel.dateTime}',style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.4
                    ),),

                  ],),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))

              ],),


          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[200],
            ),
          ),
          if(postsModel.Text!='')
              Text('${postsModel.Text}',
              style: Theme.of(context).textTheme.subtitle2,

              ),


          Container(
            width: double.infinity,
            child: Wrap(
              children: [
                MaterialButton(
                  padding: EdgeInsets.zero,

                  onPressed: (){},
                  minWidth: 1.0,
                  child: Text('#software',style: Theme.of(context).textTheme.caption!.copyWith(
                      color: defaultcolor
                  ),),
                ),  MaterialButton(
                  padding: EdgeInsets.zero,

                  onPressed: (){},
                  minWidth: 1.0,
                  child: Text('#software',style: Theme.of(context).textTheme.caption!.copyWith(
                      color: defaultcolor
                  ),),
                ),
              ],),
          ),

          if(postsModel.PostImage!='')
               Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image:  DecorationImage(image:NetworkImage('${postsModel.PostImage}'),
                    fit: BoxFit.cover,

                  )
              ),
             ),
          Row(children: [
            Expanded(
              child: InkWell(
                onTap: (){},

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: [Icon(Icons.heart_broken_outlined),
                      Text('${SocilaCubit.get(context).numlike[index]}' ,style: Theme.of(context).textTheme.caption,)

                    ],

                  ),
                ),

              ),
            )      ,
            Expanded(
              child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [
                        Icon(Icons.comment_bank_outlined),
                        Text('120' ,style: Theme.of(context).textTheme.caption,),

                        Text('Comments' ,style: Theme.of(context).textTheme.caption,)

                      ],

                    ),
                  )
              ),
            )

          ],),

          Container(
            width: double.infinity,
            height: 1.0,
            color:Colors.grey[200] ,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [

              InkWell(

                child: Row(children:  [
                  CircleAvatar(
                    backgroundImage: NetworkImage('${userModel.profileimage}'),
                    radius: 15.0,
                  ),
                  SizedBox(width: 5.0,),
                  Text('Write comment.....')
                ],),
                onTap: (){},
              ),
              SizedBox(width: 20.0,),
              Expanded(
                child: InkWell(
                  onTap: ()
                  {
                    SocilaCubit.get(context).likePost(SocilaCubit.get(context).postID[index]);

                  },
                  child: Row(
                    children:  [
                      Icon(Icons.heart_broken_outlined,
                        color:  SocilaCubit.get(context).isliked?Colors.red:Colors.grey,),
                      Text('Like',)

                    ],),
                ),
              ),
              // SizedBox(width: 20.0,),
              Expanded(child:   InkWell(
                child: Row(
                  children: const [
                    Icon(Icons.share),
                    Text('Share')

                  ],),
                onTap: (){},
              ))
            ],


            ),
          )
        ],
      ),
    ),
  );
}
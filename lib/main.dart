import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialapp/Block_Observer/BlockObserve.dart';
import 'package:socialapp/Layout/Cubit/Socialcubit.dart';
import 'package:socialapp/Layout/Cubit/socialstate.dart';
import 'package:socialapp/Layout/Social_layout.dart';
import 'package:socialapp/Modules/Login/Login_screen.dart';
import 'package:socialapp/Network/Local/Cache_helper.dart';
import 'package:socialapp/Shared/Components.dart';
import 'package:socialapp/Shared/Constant.dart';
import 'package:socialapp/Shared/Permission.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print('-----------Background');

  ShowToast(text: message.data.toString(), state: Toaststate.SUCESS);


}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
  );


  GetPermission.getNotifcationPermission().then((value) {

    print('valuepermssion${value}');
  });

  // when app is opened in foreground
  FirebaseMessaging.onMessage.listen((event) {
    print('----------- foregound');

    print('----------data${event.data.toString()}');
    ShowToast(text: event.data.toString(), state: Toaststate.SUCESS);
  });


  // when open notication

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('-----------open foregound');

    ShowToast(text: event.data.toString(), state: Toaststate.SUCESS);


  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  CacheHelper.init();
  Bloc.observer = MyBlocObserver();

  runApp( MyApp());
}


class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    Widget? start_widget;

    var uid= CacheHelper.gettoken(key: "UID");
    if(uid!=null)
    {

      start_widget=SocialLayout();
    }
    else
      {
        start_widget=SocialLogin();
      }

    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>SocilaCubit()..Getuser()..getAllposts()..updatetokenuser())
    ],
        child: BlocConsumer<SocilaCubit,SocialState>(
          builder: (context,state)
          {
          return  MaterialApp(
              debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                  backgroundColor: Colors.white70,
                  elevation: 0.0,
                  iconTheme: IconThemeData(
                      color:defaultcolor
                  ),
                  titleTextStyle: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.bold)
              ),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.shifting,
                selectedItemColor: defaultcolor,
                unselectedItemColor: Colors.black,
                showSelectedLabels: true,
                showUnselectedLabels: true,
              ),

              textTheme: TextTheme(
                subtitle1: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black
                ),
                subtitle2: TextStyle(
                  fontWeight: FontWeight.w400
                )
              ),

            ),

              home: start_widget,
            );
          },
          listener: (context,state)
          {

          },
        )



    );
  }
}



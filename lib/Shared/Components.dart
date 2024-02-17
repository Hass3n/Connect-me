
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socialapp/Shared/Constant.dart';

Widget defaultFormfield(
    {TextEditingController? Control,
    String? labeltext,
    IconData? prefixicon,
    IconData? suffixicon,
    TextInputType? type,
    bool isSecure = false,
    String? Function(String?)? validate,
    Function(String?)? change,
    Function()? suffixpress,

      Function(String?)? onsave

    }) {
  return TextFormField(
    cursorColor: defaultcolor,
    controller: Control,
    obscureText:isSecure ,
    decoration: InputDecoration(
        labelText: "${labeltext}",
        labelStyle: TextStyle(color: defaultcolor),
        suffixIcon: IconButton(onPressed: suffixpress, icon: Icon(suffixicon)),
        prefixIcon: Icon(
          prefixicon ,
          color:defaultcolor,
        ),

        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: defaultcolor)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color:defaultcolor),
            borderRadius: BorderRadius.circular(5.0))),
    validator: validate,
    onChanged: change,
    onSaved:onsave ,




  );
}





Widget defaultButton({ context, Function()? onpress,String? text })
{

  return Padding(
  padding: const EdgeInsets.all(12.0),
  child: Container(
  width:getwidthScreen(context: context),
  height: getheigthScreen(context: context,nheigth: 15),
  child: ElevatedButton(onPressed: onpress,
  child: Text("${text}"),
  style: ElevatedButton.styleFrom(
  backgroundColor: defaultcolor,

  ),




  ),
  ),
  );

}
Widget defaultAppBar({required BuildContext context,String? title, List<Widget>? action})
{
  
  return AppBar(
    title: Text(title!),
    titleSpacing: 0.0,
    leading: IconButton(onPressed: (){ Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios_new)),
    actions: action,
  );
  
}
Widget defaultTextbutton({Function()?onpress,String? txt,double? size ,FontWeight? fontWeight})
{

  return TextButton(onPressed: onpress, child: Text("${txt}" ,style: TextStyle(color: defaultcolor,fontSize: size,fontWeight:fontWeight ),));

}


 NavigateTo({ screen ,context})
{
   Navigator.push(context, MaterialPageRoute(builder: (context)=>screen));
}

Navigateandremove({ screen ,context})
{
   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>screen),(route)=>false);
}


// get width of screen

double getwidthScreen({context,nwidth=1})
{
  return MediaQuery.of(context).size.width/nwidth;
}

double getheigthScreen({context,nheigth})
{
  return MediaQuery.of(context).size.height/nheigth;
}


void ShowToast({required String text,required Toaststate state})
{


    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToastState(state),
        textColor: Colors.white,
        fontSize: 16.0
    );
}

enum Toaststate {SUCESS,ERROR,WARNING}

Color ChooseToastState(Toaststate state)
{

 late Color color;
  switch(state)
      {
    case Toaststate.SUCESS:

      color= Colors.green;

      break;

    case Toaststate.ERROR:
      color= Colors.red;
      break;

    case Toaststate.WARNING:
      color= Colors.yellow;
      break;





  }


  return color;



}

Widget defautlIconbutton({Function()? onpress,IconData? icon})
{

  return  IconButton(onPressed: onpress, icon: Icon(icon));

}

void settingModalBottomSheet(context){
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc){
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(Icons.camera_alt_outlined),
                  title: new Text('Camera'),
                  onTap: () => {

                  }
              ),
              new ListTile(
                leading: new Icon(Icons.browse_gallery_rounded),
                title: new Text('Gallery'),
                onTap: () => {

                },
              ),
            ],
          ),
        );
      }
  );
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weatherapp/ui/Admin/AddJok.dart';


class Login extends StatefulWidget {
  @override
  _FormPageState createState() => new _FormPageState();
}

class _FormPageState extends State<Login> {
  TextEditingController name = TextEditingController(), password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: new Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(184, 189, 245, 0.7),
            iconTheme: IconThemeData(
              color: Colors.black
            ),
            title: Text(
              'تسجيل دخول',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50,),
                Image.asset(
                  'images/smaile.gif',
                  color: Theme.of(context).accentColor,
                  width:200.0,
                  height: 200.0,
                ),
                SizedBox(height: 40,),
                Container(
                  margin: EdgeInsets.all(10),
                  child: new TextField(
                    decoration: new InputDecoration(
                      labelText: "البريد الالكتروني",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    textDirection: TextDirection.ltr,
                    controller: name,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: new TextField(
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "الرمز",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    textDirection: TextDirection.ltr,
                    controller: password,
                  ),
                ),
                new RaisedButton(
                  splashColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: new Text(
                    "دخول",
                    style:Theme.of(context).textTheme.bodyText1,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    if (name.text != "" && password.text != "") {
                      signIn(name.text, password.text);
                    } else if (name.text == "") {
                      showMsg("يرجى ادخال اسم المستخدم ");
                    } else if (password.text == "") {
                      showMsg("يرجى ادخال الرمز السري ");
                    } else {
                   showMsg( "يرجى التحقق من المعلومات ");
                    }
                  },
                )
              ],
            ),
          )),
    );
  }

  signIn(String name, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: name, password: password).then((_) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context) => AddJok()));
      });
    } catch (e) {
      print(e);
     showMsg(e);
    }
  }
}
showMsg(String text){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

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
            title: Text(
              'تسجيل دخول'
            ),
            centerTitle: true,
          ),
          body: new SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/cloud.png',
                  width:200.0,
                  height: 200.0,
                ),
                SizedBox(height: 30,),
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
                    style: new TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width / 20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  color: Colors.blue,
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

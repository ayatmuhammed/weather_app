import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/firebase.dart';
class FirebaseAction{
 var data=Firestore.instance.collection('icon').getDocuments();

 void LoadeDatat()async {
   await Firestore.instance.collection("Department").getDocuments().then((data) {
     print("*****");
     print(data.documents[0]['img']);
   });
 }
}
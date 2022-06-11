
import 'package:clientapp/client/panier.dart';

import 'package:clientapp/restaurant/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid ;
   static String? nom ;
   static bool exist=false ;
   static int nbrPanier =0,nbrFavoris=0,nbPlat=0;

  DatabaseService( { required this.uid});


  //Collectoin reference
  final CollectionReference clientCollection = FirebaseFirestore.instance.collection('client');


//panier
  List <Panier> _panierList(QuerySnapshot snapshot ){

    return snapshot.docs.map((doc)
    {

return Panier(id: doc.get("ID").toString(), nom: doc.get("nom").toString(), resId: doc.get("ResId").toString(), descreption:doc.get("description").toString(), prix: doc.get("prix").toInt(), categore: doc.get("categorie").toString(), quantite: doc.get("quentite").toInt());

    }).toList();

  }
  Stream<List <Panier>> get panier {
    return clientCollection.doc(uid).collection("Panier").snapshots().map((snapshot)=> _panierList(snapshot));

  }
  List <Plat> _favorisList(QuerySnapshot snapshot ){

    return snapshot.docs.map((doc)
    {

      return Plat(id: doc.get("ID").toString(), nom: doc.get("nom").toString(), resId: doc.get("ResId").toString(), descreption:doc.get("description").toString(), prix: doc.get("prix").toInt(), categore: doc.get("categorie").toString());

    }).toList();

  }
  Stream<List <Plat>> get favoris {
    return clientCollection.doc(uid).collection("Favoris").snapshots().map((snapshot)=> _favorisList(snapshot));

  }




updatUserdata(){
    clientCollection.doc(uid).get().then((value) {
      if(!value.exists){
        clientCollection.doc(uid).set({"nom":"new user" , "panier":0.toInt(),"favoris":0.toInt()});
      }
    });
}
  int _existpanier(DocumentSnapshot snapshot){
    return  snapshot.get("panier").toInt();
  }

  Stream <int> get existpanier{

    return clientCollection.doc(uid).snapshots().map((snapshot) => _existpanier(snapshot));
  }
  int _existfavoris(DocumentSnapshot snapshot){
    return  snapshot.get("favoris").toInt();
  }

  Stream <int> get existfavoris{

    return clientCollection.doc(uid).snapshots().map((snapshot) => _existfavoris(snapshot));
  }
  changenom(String s){
    return clientCollection.doc(uid).update({"nom":s});
  }
  String gatNom(){
   clientCollection.doc(uid).get().then((value) => nom=value.get("nom"));
    nom ??= "";

    return nom!;
  }
  //*******************************************************************************************
  String _Lenom(DocumentSnapshot snapshot){
    return  snapshot.get("nom").toString();
  }

  Stream <String> get Lenom{

    return clientCollection.doc(uid).snapshots().map((snapshot) => _Lenom(snapshot));
  }
//********************************************************************************************

  Future updateFavoris(Plat plat)async{
  await clientCollection.doc(uid).collection("Favoris").doc(plat.resId+""+plat.id).set({"nom":plat.nom,"description":plat.descreption,"prix":plat.prix,"ID":plat.id,"ResId":plat.resId,"categorie":plat.categore});
  }
 Future deletFavoris(Plat plat)async{
    await clientCollection.doc(uid).collection("Favoris").doc(plat.resId+""+plat.id).delete();
  }
  Future updatePanier(Plat plat , int cont,String message)async{
   await clientCollection.doc(uid).collection("Panier").doc(plat.resId+""+plat.id).set({"nom":plat.nom,"description":plat.descreption,"prix":plat.prix,"ID":plat.id,"ResId":plat.resId,"categorie":plat.categore,"quentite":cont.toInt(),"message":message});
  }
  Future deletePanier(Panier panier)async{
    await clientCollection.doc(uid).collection("Panier").doc(panier.resId+""+panier.id).delete();
  }
  bool existPlat(Plat plat){
    clientCollection.doc(uid).collection("Favoris").doc(plat.resId+""+plat.id).get().then((value) {
     exist= value.exists;
   }
   );
   return exist;
  }
  UpdateFavorisPlus()async{
     await clientCollection.doc(uid).get().then((value) => nbrFavoris=value.get("favoris").toInt());

    await clientCollection.doc(uid).update({"favoris":nbrFavoris+1});
  }
  UpdateFavorisMoin()async{
    await clientCollection.doc(uid).get().then((value) => nbrFavoris=value.get("favoris").toInt());

    await clientCollection.doc(uid).update({"favris":nbrFavoris-1});
  }
  UpdatePanierPlus()async{
    await clientCollection.doc(uid).get().then((value) => nbrPanier=value.get("panier").toInt());

    await clientCollection.doc(uid).update({"panier":nbrPanier+1});
  }
  UpdatePanierMoin()async{
    await clientCollection.doc(uid).get().then((value) => nbrPanier=value.get("panier").toInt());

    await clientCollection.doc(uid).update({"panier":nbrPanier-1});
  }
  UpdatePlatPlus(String uid)async{

    await clientCollection.doc(this.uid).collection("Panier").doc(uid).get().then((value) => nbPlat=value.get("quentite").toInt());

    await clientCollection.doc(this.uid).collection("Panier").doc(uid).update({"quentite":nbPlat+1});
  }
  UpdatePlatMoin(String uid)async{
    print("hello "+uid);
    await clientCollection.doc(this.uid).collection("Panier").doc(uid).get().then((value) => nbPlat=value.get("quentite").toInt());

    await clientCollection.doc(this.uid).collection("Panier").doc(uid).update({"quentite":nbPlat-1});
  }
}


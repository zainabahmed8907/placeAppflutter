import "package:flutter/material.dart";
import 'package:placeapp/Provider/great_place.dart';
import 'package:placeapp/screens/add_place.dart';
import 'package:provider/provider.dart';

class PlaceList extends StatelessWidget {
  const PlaceList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Great Places"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceListScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future:Provider.of<GreatPlace>(context,listen: false).getandSetPlaces(),
        builder:(ctx,snapshot)=>snapshot.connectionState == ConnectionState.waiting?
        Center(child:CircularProgressIndicator())
        :
          Consumer<GreatPlace>(
          child: Center(
            child:const Text("Got no places yet,add some")
          ),
          builder: (ctx,greatplaces,child)=>
           greatplaces.items.length<=0?child:ListView.builder(
             itemCount: greatplaces.items.length,
             itemBuilder: (ctx,i)=>ListTile(
               leading: CircleAvatar(
                 backgroundImage: FileImage(greatplaces.items[i].image),
               ),
               title: Text(greatplaces.items[i].title),
               onTap: (){
                 //go to detailed page
               },

             ),

           ),
          
        ),
        )
    );
      
      
    
  }
}

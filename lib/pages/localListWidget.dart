import 'package:flutter/material.dart';
import 'package:virtualorder_app/model/local.dart';

import 'localDetails.dart';


class LocalListWidget extends StatefulWidget{

  LocalListWidget ({Key key, this.locals}) : super(key: key);

  final List <Local> locals;

  // The framework callls crateState the first time a widget 

  @override
  _LocalListWidgetState createState() => _LocalListWidgetState();
  
}

class _LocalListWidgetState extends State<LocalListWidget> {
  Set<Local> _localCart = Set<Local>();

  @override  
  void initState() {
    // state to configure animations or platforms subscritpions.
    super.initState();
  }

  void _handleCartChanged (Local local, bool inCart){
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LocalDetails()));  
    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LocalDetails()));
    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LocalDetails(local)),
                    );
  }

  @override
  Widget build (BuildContext context){
  return ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: widget.locals.map ((Local product) {
          return LocalListItem(
            product: product,
            inCart: _localCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
    );
  }
}

typedef void CartChagedCallback (Local product, bool inCart);

class LocalListItem extends StatelessWidget{
  LocalListItem({this.product, this.inCart, this.onCartChanged})
  :super(key: ObjectKey(product));

  final Local product;
  final bool inCart;
  final CartChagedCallback onCartChanged;

  Color _getColor(BuildContext context) {

    return inCart ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle (BuildContext context){
    if (!inCart) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }


  @override
  Widget build(BuildContext context){
    return ListTile(
      onTap:(){
        
        onCartChanged(product, inCart);
        //RandomWords();
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text (product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
    
  }

}


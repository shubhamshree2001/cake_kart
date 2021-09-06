import 'package:flutter/material.dart';
import 'package:notification/models/cart.dart';
import 'package:notification/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {

  final CartModel cartDetails;

  CartItem({this.cartDetails});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartDetails.name),
      direction: DismissDirection.endToStart ,
      confirmDismiss: (_){
        return showDialog(
          context: context,
          builder: (ctx)=>AlertDialog(
            title: Text('Are you sure ?'),
            content: Text('Do you want to remove ${cartDetails.name} from the cart ?'),
            actions: <Widget>[
              FlatButton(onPressed: (){Navigator.of(ctx).pop(false);},child: Text('No'),),
              FlatButton(onPressed: (){Navigator.of(ctx).pop(true);},child: Text('Yes'),),
            ],
          )
        ); 
      },
      onDismissed: (_) {
        final _cartProvider = Provider.of<CartProvider>(context,listen: false);
        _cartProvider.removeFromCartList(cartDetails.name);
      },
      background: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 15),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete,size: 30,color: Colors.grey[900],)
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _imageHolder(context),
            _itemDescription(context),
            _countDisplay(context),
          ],
        ),
      ),
    );
  }

  Widget _imageHolder(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(6),
        image: DecorationImage(image: AssetImage("assets/images/Rcake2.jpg"),fit: BoxFit.cover),
      ),
    );
  }

  Widget _itemDescription(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${cartDetails.name}",
              style: TextStyle(
                fontSize: 15,
                height: 1.2,
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              "Premium",
              style: TextStyle(
                fontSize: 13,
                height: 1
              ),
            ),
            Text(
              "${cartDetails.price}",
              style: TextStyle(
                fontSize: 14,
                height: 1.8,
                color: Colors.red
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _countDisplay(BuildContext context) {
    final _cartProvider = Provider.of<CartProvider>(context,listen: false);
    return Container(
      padding: EdgeInsets.all(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              _cartProvider.decreaseCount(cartDetails.name);
            },
            child: Container(
              child: Icon(Icons.remove_circle,size: 20,color: Colors.grey,)
            ),
          ),
          Container(
            child: Text(
              "${cartDetails.quantity}",
              style: TextStyle(
                height: 1.5
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _cartProvider.increaseCount(cartDetails.name);
            },
            child: Container(
              child: Icon(Icons.add_circle,size: 20,color: Colors.blueAccent[700],)
            ),
          ),
        ],
      ),
    );
  }
}
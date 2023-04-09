import 'package:flutter/material.dart';
import 'package:shoping_app/Add_to_cart.dart';
import 'package:shoping_app/constant.dart';
import 'package:shoping_app/shop_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.shopIndex, required this.subtotoal});
  final int shopIndex;
  final subtotoal;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ShopButton,
        title: Text('Check Out'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text('Name', style: fontsize1)),
                  Expanded(child: Text('Qty', style: fontsize1)),
                  Expanded(child: Text('Price', style: fontsize1)),
                  Expanded(child: Text('Total', style: fontsize1))
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: shopsList[widget.shopIndex]['Requirements'].length,
            itemBuilder: (context, index) {
              num totalItemRate =
                  shopsList[widget.shopIndex]['Requirements'][index].qty *
                      shopsList[widget.shopIndex]['Requirements'][index].rate;
              return SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(.1)),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              shopsList[widget.shopIndex]['Requirements'][index]
                                  .itemName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            textDirection: TextDirection.ltr,
                            shopsList[widget.shopIndex]['Requirements'][index]
                                .qty
                                .toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            textDirection: TextDirection.ltr,
                            shopsList[widget.shopIndex]['Requirements'][index]
                                .rate
                                .toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            textDirection: TextDirection.ltr,
                            '$totalItemRate',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount : ",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w500, color: Shoptext),
              ),
              Text(
                widget.subtotoal.toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: Shoptext),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              child: Text('Confirm Order'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ShopButton,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => orderplaced(),
                    ),
                    (route) => false);
                shopsList[widget.shopIndex]['Requirements'].clear();
              },
            ),
          ),
        ),
      ]),
    );
  }
}

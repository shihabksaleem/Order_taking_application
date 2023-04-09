import 'package:flutter/material.dart';
import 'package:shoping_app/shop_model.dart';
import 'Add_to_cart.dart';
import 'Amount_Container.dart';
import 'cart_page.dart';
import 'constant.dart';
import 'models/requirements_model.dart';

List<String> items = [
  'Apple',
  'Orange',
  'Pinaple',
  'Grapes',
  'Mango',
];
List<Map<String, dynamic>> itemRates = [
  {'itmname': 'Apple', 'itmprice': 80.00},
  {'itmname': 'Orange', 'itmprice': 50.00},
  {'itmname': 'Pinaple', 'itmprice': 40.00},
  {'itmname': 'Grapes', 'itmprice': 90.00},
  {'itmname': 'Mango', 'itmprice': 75.00},
];

class AddRequirementsScreen extends StatefulWidget {
  const AddRequirementsScreen({
    Key? key,
    required this.shopIndex,
  }) : super(key: key);
  final int shopIndex;

  @override
  State<AddRequirementsScreen> createState() => _AddRequirementsScreenState();
}

class _AddRequirementsScreenState extends State<AddRequirementsScreen> {
  // TextEditingController itemRate = TextEditingController();
  num sum = 0.0;
  var totalamount;
  num subTotal = 0.00;
  num discountAmount = 0.00;
  num gstAmount = 0.00;

  getTotaAmount() {
    subTotal = 0.00;
    discountAmount = 0.00;
    gstAmount = 0.00;
    totalamount = 0.0;
    for (var i = 0;
        i < shopsList[widget.shopIndex]['Requirements'].length;
        i++) {
      totalamount = totalamount +
          (shopsList[widget.shopIndex]['Requirements'][i].rate *
              shopsList[widget.shopIndex]['Requirements'][i].qty);
    }
    sum = totalamount;
    gstAmount = (totalamount * 12) / 100;
    discountAmount = (totalamount * discount) / 100;
    subTotal = (totalamount - discountAmount) + gstAmount;
    setState(() {});
  }

  final TextEditingController itemName = TextEditingController();
  final TextEditingController itemQty = TextEditingController();
  final TextEditingController itemRate = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  num discount = 0.00;

  String dropDownItem = items.first;
  String dropDownItemRate = itemRates.first['itmprice'].toString();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Requirements'),
          backgroundColor: ShopButton,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  itemName.text = dropDownItem;
                  itemRate.text = dropDownItemRate;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DropdownButton(
                              value: dropDownItem,
                              items: items.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                itemName.text = dropDownItem;
                                itemRate.text = dropDownItemRate;
                                setState(() {
                                  dropDownItem = value!;
                                  dropDownItemRate = itemRates
                                      .firstWhere((element) =>
                                          element['itmname'] ==
                                          value)['itmprice']
                                      .toString();
                                  itemName.text = dropDownItem;
                                  itemRate.text = dropDownItemRate;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 97, 61, 230),
                                      width: 2.0),
                                ),
                                hintText: 'Enter Your Quantity',
                              ),
                              keyboardType: TextInputType.number,
                              controller: itemQty,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a value';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextField(
                              enabled: false,
                              decoration: const InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 97, 61, 230),
                                      width: 2.0),
                                ),
                                hintText: 'Amount',
                              ),
                              keyboardType: TextInputType.number,
                              controller: itemRate,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              width: 120,
                              height: 55,
                              color: ShopButton,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.red.withOpacity(0),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(2),
                                      ),
                                      side: BorderSide(color: Colors.white)),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    shopsList[widget.shopIndex]['Requirements']
                                        .add(
                                      RequirementsModel(
                                          itemName: itemName.text,
                                          qty: double.parse(itemQty.text),
                                          rate: double.parse(itemRate.text)),
                                    );
                                    getTotaAmount();
                                    Navigator.pop(context);
                                  }

                                  setState(() {});
                                  itemName.clear();
                                  itemQty.clear();
                                  itemRate.clear();
                                },
                                child: Text('Add'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              children: [
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
                  flex: 4,
                  child: ListView.builder(
                    itemCount:
                        shopsList[widget.shopIndex]['Requirements'].length,
                    itemBuilder: (context, index) {
                      num totalItemRate = shopsList[widget.shopIndex]
                                  ['Requirements'][index]
                              .qty *
                          shopsList[widget.shopIndex]['Requirements'][index]
                              .rate;
                      return SizedBox(
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(.1)),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      shopsList[widget.shopIndex]
                                              ['Requirements'][index]
                                          .itemName,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    textDirection: TextDirection.ltr,
                                    shopsList[widget.shopIndex]['Requirements']
                                            [index]
                                        .qty
                                        .toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    textDirection: TextDirection.ltr,
                                    shopsList[widget.shopIndex]['Requirements']
                                            [index]
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Divider(
                        thickness: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Discount Percentage',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Shoptext),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextField(
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 97, 61, 230),
                                        width: 2.0),
                                  ),
                                  hintText: '0.00 %',
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  discount = double.parse(value);
                                  getTotaAmount();

                                  setState(() {
                                    // discountController.text = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      AmountContainer(totalAmount: sum, discount: discount),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('BUY'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ShopButton,
                          ),
                          onPressed: () {
                            if (sum == 0) {
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CartPage(
                                    shopIndex: widget.shopIndex,
                                    subtotoal: subTotal),
                              ));
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

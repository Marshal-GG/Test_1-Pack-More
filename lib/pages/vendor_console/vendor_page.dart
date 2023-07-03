import 'package:flutter/material.dart';

class VendorPage extends StatefulWidget {
  @override
  _VendorPageState createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage> {
  List<String> categories = ['Fruits', 'Vegetables', 'Dairy'];
  String? selectedCategory;
  List<String> items = [];
  Map<String, int> quantities = {};
  Map<String, double> prices = {};

  _VendorPageState() {
    selectedCategory = categories.isNotEmpty ? categories[0] : null;
  }

  void addItem(String item) {
    setState(() {
      items.add(item);
    });
  }

  void updateQuantity(String item, int quantity) {
    setState(() {
      quantities[item] = quantity;
    });
  }

  void updatePrice(String item, double price) {
    setState(() {
      prices[item] = price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor Page'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Vendor Name'),
            subtitle: Text('Vendor ABC'), // Replace with vendor's name
          ),
          Divider(),
          ExpansionTile(
            title: Text('Categories'),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String category = categories[index];
                  bool isSelected = category == selectedCategory;
                  return ListTile(
                    title: Text(category),
                    selected: isSelected,
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                      });
                      // Perform actions when a category is selected
                      print('Selected category: $category');
                    },
                  );
                },
              ),
            ],
          ),
          Divider(),
          selectedCategory != null
              ? Text(
                  'You have selected: $selectedCategory',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                )
              : SizedBox(),
          Divider(),
          ExpansionTile(
            title: Text('Items'),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  String item = items[index];
                  return ListTile(
                    title: Text(item),
                    // Add your logic here to handle item selection
                    onTap: () {
                      // Perform actions when an item is selected
                      print('Selected item: $item');
                    },
                  );
                },
              ),
              ListTile(
                title: Text('Add Item'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController itemController =
                          TextEditingController();
                      return AlertDialog(
                        title: Text('Add Item'),
                        content: TextField(
                          controller: itemController,
                          decoration: InputDecoration(
                            labelText: 'Item Name',
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Add'),
                            onPressed: () {
                              String newItem = itemController.text.trim();
                              if (newItem.isNotEmpty) {
                                addItem(newItem);
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Divider(),
          ExpansionTile(
            title: Text('Quantities'),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  String item = items[index];
                  return ListTile(
                    title: Text(item),
                    subtitle: Text('Quantity: ${quantities[item] ?? 0}'),
                    // Add your logic here to handle quantity setting
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          int currentQuantity = quantities[item] ?? 0;
                          return AlertDialog(
                            title: Text('Set Quantity'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Item: $item'),
                                SizedBox(height: 16.0),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    int quantity = int.tryParse(value) ?? 0;
                                    updateQuantity(item, quantity);
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Quantity',
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Save'),
                                onPressed: () {
                                  // Perform actions when quantity is saved
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          Divider(),
          ExpansionTile(
            title: Text('Prices'),
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  String item = items[index];
                  return ListTile(
                    title: Text(item),
                    subtitle: Text('Price: ${prices[item] ?? 0.0}'),
                    // Add your logic here to handle price setting
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          double currentPrice = prices[item] ?? 0.0;
                          return AlertDialog(
                            title: Text('Set Price'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Item: $item'),
                                SizedBox(height: 16.0),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    double price =
                                        double.tryParse(value) ?? 0.0;
                                    updatePrice(item, price);
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Price',
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text('Save'),
                                onPressed: () {
                                  // Perform actions when price is saved
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controller/getx/category_controller_getx.dart';

class CategoryWidget extends StatefulWidget {
  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<DocumentSnapshot> category = [];
  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    CollectionReference categoryRef =
        FirebaseFirestore.instance.collection('categories');
    QuerySnapshot querySnapshot = await categoryRef.get();
    setState(() {
      category = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final categoryController = Get.find<CategoryControllerGetx>();

    // CollectionReference categories =
    //     FirebaseFirestore.instance.collection("categories");
    // final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return Expanded(
      flex: 0,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 8),
        child: Column(
          children: [      
            Hero(
              tag: "category",
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: category
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: ActionChip(
                            label: Text(
                              e['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color:
                                    (categoryController.categoryModelGetx.i ==
                                            category.indexOf(e))
                                        ? colorScheme.background
                                        : colorScheme.onBackground,
                              ),
                            ),
                            backgroundColor:
                                (categoryController.categoryModelGetx.i ==
                                        category.indexOf(e))
                                    ? colorScheme.primary
                                    : colorScheme.background,
                            elevation:
                                (categoryController.categoryModelGetx.i ==
                                        category.indexOf(e))
                                    ? 6
                                    : 0,
                            onPressed: () {
                              setState(() {
                                categoryController.changeCategory(
                                  temp: category.indexOf(e),
                                );
                              });
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

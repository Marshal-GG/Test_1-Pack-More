import 'package:get/get.dart';
import '../../models/getx/category_model_getx.dart';

class CategoryControllerGetx extends GetxController {
  CategoryModelGetx categoryModelGetx = CategoryModelGetx(i: 0);

  changeCategory({required int temp}) {
    categoryModelGetx.i = temp;
    update();
  }
}

// class CategoryControllerGetx extends GetxController {
//   CategoryModelGetx? categoryModelGetx;

//   @override
//   void onInit() {
//     super.onInit();
//     categoryModelGetx = CategoryModelGetx(i: 0);
//   }

//   changeCategory({required int temp}) {
//     categoryModelGetx?.i = temp;
//     update();
//   }
// }

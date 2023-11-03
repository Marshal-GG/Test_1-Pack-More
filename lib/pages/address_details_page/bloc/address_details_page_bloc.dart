import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_1/core/firebase/repositories/shipping_address/shipping_address_repo.dart';
import 'package:test_1/core/models/models.dart';

part 'address_details_page_event.dart';
part 'address_details_page_state.dart';

class AddressDetailsPageBloc
    extends Bloc<AddressDetailsPageEvent, AddressDetailsPageState> {
  final ShippingAddressRepository shippingAddressRepository =
      ShippingAddressRepository();
  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  bool isLoading = false;
  ShippingAddress shippingAddress = ShippingAddress(
    name: '',
    email: '',
    phone: '',
    address: '',
    city: '',
    state: '',
    pincode: '',
  );

  AddressDetailsPageBloc() : super(AddressDetailsPageInitial()) {
    on<LoadAddressDetails>((event, emit) async {
      if (!isLoading) {
        isLoading = true;

        shippingAddress =
            await shippingAddressRepository.fetchShippingAddress(userUid);

        isLoading = false;
        emit(AddressDetailsPageLoaded(
          isLoaded: isLoading,
          shippingAddress: shippingAddress,
        ));
      }
    });
    on<UpdateAddressDetails>((event, emit) async {
      if (!isLoading) {
        isLoading = true;

        shippingAddress = event.shippingAddress;
        await shippingAddressRepository.updateShippingAddress(
            userUid, shippingAddress);

        isLoading = false;
        emit(AddressDetailsPageLoaded(
          isLoaded: isLoading,
          shippingAddress: shippingAddress,
        ));
      }
    });
  }
}

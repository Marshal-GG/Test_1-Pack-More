part of 'address_details_page_bloc.dart';

sealed class AddressDetailsPageEvent extends Equatable {
  const AddressDetailsPageEvent();

  @override
  List<Object> get props => [];
}

class LoadAddressDetails extends AddressDetailsPageEvent {}

class UpdateAddressDetails extends AddressDetailsPageEvent {
  final ShippingAddress shippingAddress;

  UpdateAddressDetails({required this.shippingAddress});

  @override
  List<Object> get props => [shippingAddress];
}
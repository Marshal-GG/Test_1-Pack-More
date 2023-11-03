part of 'address_details_page_bloc.dart';

sealed class AddressDetailsPageState extends Equatable {
  const AddressDetailsPageState();

  @override
  List<Object> get props => [];
}

final class AddressDetailsPageInitial extends AddressDetailsPageState {}

class AddressDetailsPageLoaded extends AddressDetailsPageState {
  final bool isLoaded;
  final ShippingAddress shippingAddress;

  AddressDetailsPageLoaded({
    required this.isLoaded,
    required this.shippingAddress,
  });

  @override
  List<Object> get props => [
        isLoaded,
        shippingAddress,
      ];
}

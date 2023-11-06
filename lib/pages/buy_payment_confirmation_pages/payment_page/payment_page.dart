import '../../../core/routes/routes_config.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedOption = 'Cash on Devlivery';
  bool isUPIAvailable = false;
  bool isCODAvailable = true;
  bool isCCAvailable = false;
  bool isEMIAvailable = false;
  bool isNetBankingAvailable = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<PaymentPageBloc, PaymentPageState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Payments'),
            actions: [
              FilledButton(
                onPressed: () {
                  setState(() {});
                  BlocProvider.of<PaymentPageBloc>(context).add(
                      PaymentPageConfirmCheckoutEvent(
                          paymentMethod: selectedOption));
                  if ((state is PaymentPageSubmittedState) &&
                      !state.isError &&
                      !state.isLoading) {
                    Navigator.pushNamed(context, '/orders-page');
                  } else {
                    print('error');
                  }
                },
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Continue'),
              ),
              Gap(20)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildPaymentOptions(colorScheme),
                buildPriceDetailsCard(),
              ],
            ),
          ),
        );
      },
    );
  }

  Card buildPaymentOptions(ColorScheme colorScheme) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Payment options', style: TextStyle(fontSize: 20)),
          ),
          Divider(),
          RadioListTile(
            title: Row(
              children: [
                Text('Cash on Devlivery'),
                Spacer(),
                Icon(Icons.payments_outlined)
              ],
            ),
            subtitle: isCODAvailable
                ? null
                : Text(
                    'Unavailable !!',
                    style: TextStyle(
                        color: colorScheme.onBackground.withOpacity(0.5)),
                  ),
            value: 'Cash on Devlivery',
            groupValue: selectedOption,
            onChanged: isCODAvailable
                ? (value) {
                    setState(() {
                      selectedOption = value as String;
                    });
                  }
                : null,
          ),
          RadioListTile(
            title: Text('UPI'),
            subtitle: isUPIAvailable
                ? null
                : Text('Unavailable !!',
                    style: TextStyle(
                        color: colorScheme.onBackground.withOpacity(0.5))),
            value: 'UPI',
            groupValue: selectedOption,
            onChanged: isUPIAvailable
                ? (value) {
                    setState(() {
                      selectedOption = value as String;
                    });
                  }
                : null,
          ),
          RadioListTile(
            title: Text('Net Banking'),
            subtitle: isNetBankingAvailable
                ? null
                : Text('Unavailable !!',
                    style: TextStyle(
                        color: colorScheme.onBackground.withOpacity(0.5))),
            value: 'Net Banking',
            groupValue: selectedOption,
            onChanged: isNetBankingAvailable
                ? (value) {
                    setState(() {
                      selectedOption = value as String;
                    });
                  }
                : null,
          ),
          RadioListTile(
            title: Text('Credit Card'),
            subtitle: isCCAvailable
                ? null
                : Text('Unavailable !!',
                    style: TextStyle(
                        color: colorScheme.onBackground.withOpacity(0.5))),
            value: 'Credit Card',
            groupValue: selectedOption,
            onChanged: isCCAvailable
                ? (value) {
                    setState(() {
                      selectedOption = value as String;
                    });
                  }
                : null,
          ),
          RadioListTile(
            title: Text('EMI (Easy Installments)'),
            subtitle: isEMIAvailable
                ? null
                : Text('Unavailable !!',
                    style: TextStyle(
                        color: colorScheme.onBackground.withOpacity(0.5))),
            value: 'EMI',
            groupValue: selectedOption,
            onChanged: isEMIAvailable
                ? (value) {
                    setState(() {
                      selectedOption = value as String;
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Card buildPriceDetailsCard() {
    return Card(
      child: BlocBuilder<ShoppingCartPageBloc, ShoppingCartPageState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Price Details',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap(5),
                    Row(
                      children: [
                        Text('Sub-Total'),
                        Spacer(),
                        Text(
                          '₹${(state as ShoppingCartLoaded).subTotal.toString()}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Coupon Discount'),
                        Spacer(),
                        Text(
                          '₹-${state.couponDiscount.toString()}',
                          style: TextStyle(fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Delivery Fee'),
                        Spacer(),
                        Text(
                          '₹${state.deliveryFee.toString()}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          '₹${state.totalPrice.toString()}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

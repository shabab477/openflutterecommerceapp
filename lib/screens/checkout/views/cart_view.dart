// Checkout Cart View Screen
// Author: openflutterproject@gmail.com
// Date: 2020-02-17

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:openflutterecommerce/config/theme.dart';
import 'package:openflutterecommerce/widgets/action_card.dart';
import 'package:openflutterecommerce/widgets/delivery_method.dart';
import 'package:openflutterecommerce/widgets/payment_card.dart';
import 'package:openflutterecommerce/widgets/summary_line.dart';
import 'package:openflutterecommerce/widgets/widgets.dart';

import '../../wrapper.dart';
import '../checkout.dart';

class CartView extends StatefulWidget {

  final Function changeView;

  const CartView({Key key, this.changeView}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {

    final bloc = BlocProvider.of<CheckoutBloc>(context);
    final ThemeData _theme = Theme.of(context);
    final double width = MediaQuery.of(context).size.width - AppSizes.sidePadding*2;

    return BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is CheckoutErrorState) {
            return Container(
                padding: EdgeInsets.all(AppSizes.sidePadding),
                child: Text('An error occured',
                  style: _theme.textTheme.headline3
                    .copyWith(color: _theme.errorColor)));
          }
          return Container();
        },
        child: BlocBuilder(
          bloc: bloc,
          builder: (BuildContext context, CheckoutState state) {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  OpenFlutterBlockSubtitle(
                    title: 'Shipping Address',
                    width: width
                  ),
                  OpenFlutterActionCard(
                    title: 'Jane Doe',
                    linkText: 'Change',
                    onLinkTap: ( () => {
                      BlocProvider.of<CheckoutBloc>(context)
                          .add(CheckoutShowAddNewCardEvent()),
                      widget.changeView(changeType: ViewChangeType.Backward)
                    }),
                    child: RichText(
                      text: TextSpan(
                        text:"3 Newbridge Court Chino Hills, CA 91709, United States",
                        style: _theme.textTheme.headline5.copyWith(
                          color: _theme.primaryColor
                        )
                      ),
                      maxLines: 2,
                    )
                  ),

                  OpenFlutterBlockSubtitle(
                    title: 'Payment',
                    width: width,
                    linkText: "Change",
                    onLinkTap: ( () => {

                    }),
                  ),
                  OpenFlutterPaymentCard(
                    cardNumber: "**** **** **** 3947",
                  ),

                  OpenFlutterBlockSubtitle(
                    title: 'Delivery Method',
                    width: width,
                    linkText: "Change",
                    onLinkTap: ( () => {

                    }),
                  ),

                  OpenFlutterDeliveryMethod(

                  ),
                  Padding(padding: EdgeInsets.only(top: AppSizes.sidePadding*3)),

                  OpenFlutterSummaryLine(
                    title: 'Order',
                    summary: '\$112'
                  ),
                  Padding(padding: EdgeInsets.only(top: AppSizes.sidePadding)),

                  OpenFlutterSummaryLine(
                    title: 'Delivery',
                    summary: '\$15'
                  ),
                  Padding(padding: EdgeInsets.only(top: AppSizes.sidePadding)),

                  OpenFlutterSummaryLine(
                    title: 'Summary',
                    summary: '\$127'
                  ),
                  Padding(padding: EdgeInsets.only(top: AppSizes.sidePadding)),

                  OpenFlutterButton(
                    title: 'SUBMIT ORDER',
                    onPressed: ( () => {

                    }),
                  )
                ],
              )
            );
          }
        )
    );
  }
}
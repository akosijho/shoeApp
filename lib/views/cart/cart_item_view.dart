import 'package:flutter/material.dart';
import 'package:flutter_shoe_app/extensions/double_extension.dart';
import 'package:flutter_shoe_app/views/application/application_view_model.dart';
import 'package:flutter_shoe_app/views/home/shoe_object.dart';
import 'package:flutter_shoe_app/views/shoe_details/shoe_details_view.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class CartItemView extends StatelessWidget {
  const CartItemView({Key? key, required this.shoe, required this.quantity})
      : super(key: key);

  final Shoe shoe;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ApplicationViewModel>.nonReactive(
        disposeViewModel: false,
        viewModelBuilder: () => Provider.of<ApplicationViewModel>(context),
        builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ShoeDetailsView(shoe,
                      applicationViewModel:
                          Provider.of<ApplicationViewModel>(context));
                }));
              },
              child: Row(
                children: <Widget>[
                  Column(
                    children: [
                      ClipRect(
                        child: Image.asset(
                          shoe.image,
                          width: 127.93,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 25,
                        width: 87,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                viewModel.removeFromCart(shoe);
                              },
                              child: Container(
                                width: 29,
                                height: 30,
                                color: const Color(0xff1F2732),
                                child: const Center(
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 29,
                              height: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.black,
                              )),
                              child: Center(
                                  child: Text(
                                quantity.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                            ),
                            InkWell(
                              onTap: () {
                                viewModel.addToCart(shoe);
                              },
                              child: Container(
                                width: 29,
                                height: 30,
                                color: const Color(0xff1F2732),
                                child: const Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shoe.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          (shoe.price * quantity).toCurrencyFormat(),
                          //viewModel.getTotalPrice(shoe),
                          style: TextStyle(
                            color: const Color(0xff1F2732).withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

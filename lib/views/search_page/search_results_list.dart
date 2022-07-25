import 'package:flutter/material.dart';
import 'package:flutter_shoe_app/views/home/shoe_object.dart';
import 'package:flutter_shoe_app/views/search_page/search_model.dart';
import 'package:flutter_shoe_app/views/shoe_details/shoe_details_view.dart';
import 'package:stacked/stacked.dart';

class SearchResultsList extends ViewModelWidget<SearchModel> {
  final Shoe shoe;

  const SearchResultsList(this.shoe, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, SearchModel viewModel) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ShoeDetailsView(shoe);
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: <Widget>[
            Image.asset(
              shoe.image,
              width: 127.93,
              height: 127.93,
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
                    shoe.price,
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
  }
}

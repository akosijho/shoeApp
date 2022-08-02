import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_shoe_app/resources/assets/icons/svg_icons.dart';
import 'package:flutter_shoe_app/utils/constants.dart';
import 'package:flutter_shoe_app/views/application/application_view_model.dart';
import 'package:flutter_shoe_app/views/home/home_view_model.dart';
import 'package:flutter_shoe_app/views/home/shoe_category_view.dart';
import 'package:flutter_shoe_app/views/home/shoe_horizontal_item.dart';
import 'package:flutter_shoe_app/views/home/shoe_vertical_item.dart';
import 'package:flutter_shoe_app/views/search_page/search_page_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeViewWidget extends ViewModelWidget<HomeViewModel> {
  const HomeViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: SvgPicture.asset(
              SvgIcons.searchIcon,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) {
                    return ViewModelBuilder<
                        ApplicationViewModel>.reactive(
                        disposeViewModel: false,
                        viewModelBuilder: () =>
                            Provider.of<ApplicationViewModel>(
                                context),
                        builder: (context, viewModel, child) {
                          return const SearchPageView();
                        });
                  }));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Flexible(
            child: ListView(
              primary: false,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(kDefaultPaddin, 0, 0, 16),
                  child: Text(
                    'Shoes',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Avalon',
                      fontSize: 26,
                    ),
                  ),
                ),
                ShoeCategoryView(),
              ],
            ),
          ),
          Flexible(
            child: SizedBox(
              height: 348,
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                scrollDirection: Axis.horizontal,
                itemCount: viewModel.items.length,
                separatorBuilder: (context, _) => const SizedBox(width: 16),
                itemBuilder: (context, index) => ShoeHorizontalItem(
                  viewModel.items[index],
                ),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${viewModel.items.length.toString()} OPTIONS',
                    style: TextStyle(
                      fontFamily: 'Avalon',
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff1F2732).withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                //height: 20,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
            ],
          ),
          ListView.separated(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: viewModel.items.length,
            separatorBuilder: (context, _) => const Divider(
              color: Color(0xffF4F4F4),
              height: 1,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            itemBuilder: (context, index) => ShoeVerticalItem(
              item: viewModel.items[index],
            ),
          ),
        ]),
      ),
    );
  }
}

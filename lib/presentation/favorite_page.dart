import 'package:coofit/provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../common/state_enum.dart';
import '../model/menu/menu_lite_response.dart';
import '../widgets/custom_widget.dart';
import 'detail_page.dart';

class FavoritePage extends StatelessWidget {

  static const routeName = '/favorite_page';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, value, child) {
        if (value.state == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.state == RequestState.Success) {
          final List<MenuLiteResponse>? menus = value.menus;
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 36,
                horizontal:18
            ),
            child: MasonryGridView.count(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 16,
              itemCount: menus?.length,
              itemBuilder: (context, index) {
                return _buildListItem(context,menus!.elementAt(index));
              },
            ),
          );
        } else if (value.state == RequestState.Error) {
          return Center(
            child: Text(
                value.message
            ),
          );
        } else if (value.state == RequestState.Default) {
          return Container();
        } else if (value.state == RequestState.Empty) {
          return Center(child: Text(value.message));
        } else {
          return Container();
        }
      }
    );
  }

  Widget _buildListItem(BuildContext context, MenuLiteResponse menu) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName, arguments: menu.menuId);
      },
      child: MenuLiteResponseListWidget(menu: menu),
    );
  }
}
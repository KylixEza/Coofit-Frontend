import 'package:coofit/provider/favorite_provider.dart';
import 'package:coofit/widgets/footer.dart';
import 'package:coofit/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../common/state_enum.dart';
import '../model/menu/menu_lite_response.dart';
import '../utils/route_observer.dart';
import '../widgets/custom_widget.dart';
import 'detail_page.dart';

class FavoritePage extends StatefulWidget {

  static const routeName = '/favorite_page';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> with RouteAware  {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar(context, 'Favorite'),
      body: _buildPage(context),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<FavoriteProvider>(context, listen: false)
          .getFavorites();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<FavoriteProvider>(context, listen: false)
        .getFavorites();
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
import 'package:coofit/common/state_enum.dart';
import 'package:coofit/model/menu/menu_lite_response.dart';
import 'package:coofit/presentation/detail_page.dart';
import 'package:coofit/presentation/prediction_page.dart';
import 'package:coofit/provider/home_provider.dart';
import 'package:coofit/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home_page';

  @override
  State<StatefulWidget> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coofit"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, PredictionPage.routeName);
            },
            icon: const Icon(Icons.fastfood),
            padding: const EdgeInsets.symmetric(horizontal: 16.0)
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite), padding: const EdgeInsets.symmetric(horizontal: 16.0)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person), padding: const EdgeInsets.symmetric(horizontal: 16.0))
        ],
      ),
      body: buildList(context)
    );
  }

  Widget buildList(BuildContext context) {
    return Consumer<HomeProvider>(
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
              crossAxisCount: 2,
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
      },
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
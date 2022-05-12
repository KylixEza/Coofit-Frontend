import 'package:coofit/common/state_enum.dart';
import 'package:coofit/model/menu/menu_lite_response.dart';
import 'package:coofit/presentation/detail_page.dart';
import 'package:coofit/presentation/prediction_page.dart';
import 'package:coofit/provider/home_provider.dart';
import 'package:coofit/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home_page';

  @override
  State<StatefulWidget> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  String query = '';
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, FavoritePage.routeName);
              },
              icon: const Icon(Icons.favorite), padding: const EdgeInsets.symmetric(horizontal: 16.0)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person), padding: const EdgeInsets.symmetric(horizontal: 16.0))
        ],
      ),
      body: _buildPage(context)
    );
  }

  Widget _buildPage(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (context, value, _) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 24
                ),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Find your favorite restaurant or menu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onChanged: (String s) {
                    setState(() {
                      query = s;
                      if (query.isEmpty) {
                        value.getTopMenus();
                      } else {
                        value.searchMenu(query);
                      }
                    });
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: _buildList(context),
                ),
              ),
            ],
          );
        }
    );
  }

  Widget _buildList(BuildContext context) {
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
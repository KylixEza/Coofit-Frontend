import 'package:coofit/common/state_enum.dart';
import 'package:coofit/model/menu/menu_lite_response.dart';
import 'package:coofit/presentation/detail_page.dart';
import 'package:coofit/provider/home_provider.dart';
import 'package:coofit/widgets/custom_widget.dart';
import 'package:coofit/widgets/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
    super.initState();
    _controller = TextEditingController();
    Future.microtask(() => Provider.of<HomeProvider>(context, listen: false).getTopMenus());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildNavBar(context, 'Home'),
      body: _buildPage(context),
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
                    vertical: 12
                ),
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Find some menu in here',
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
                child: _buildList(context)
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
            return Center(
              child: Lottie.asset('RedLoading.json', width: 200, height: 200),
            );
          } else if (value.state == RequestState.Success) {
            final List<MenuLiteResponse>? menus = value.menus;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal:18
              ),
              child: MasonryGridView.count(
                crossAxisCount: 6,
                mainAxisSpacing: 4,
                crossAxisSpacing: 12,
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
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('SearchEmpty.json', width: 200, height: 200),
                  const SizedBox(height: 32),
                  const Text('We can\'t find what are you looking for')
                ]
              ),
            );
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
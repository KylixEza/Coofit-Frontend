import 'package:coofit/model/menu/menu_lite_response.dart';
import 'package:flutter/material.dart';

class MenuLiteResponseListWidget extends StatelessWidget {

  final MenuLiteResponse menu;

  const MenuLiteResponseListWidget({Key? key,
    required this.menu
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color difficultyColor = Colors.green;
    switch(menu.difficulty) {
      case "Easy": {
        difficultyColor = Colors.green;
      }
      break;
      case "Medium": {
        difficultyColor = Colors.yellow;
      }
      break;
      case "Hard": {
        difficultyColor = Colors.red;
      }
      break;
    }

    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0)
                ),
                child: Image.network(
                  menu.image,
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        const SizedBox(
                          width: 2.0,
                        ),
                        Text(
                            menu.rating.toString()
                        )
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text("+- ${menu.cookTime} menit"),
                    const SizedBox(height: 4.0),
                    Card(
                      color: difficultyColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0
                        ),
                        child: Text(
                            menu.difficulty,
                          style: const TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ],
    );
  }
}
import 'package:coofit/common/state_enum.dart';
import 'package:coofit/model/favorite/favorite_body.dart';
import 'package:coofit/model/menu/menu_response.dart';
import 'package:coofit/model/review/review_response.dart';
import 'package:coofit/provider/detail_provider.dart';
import 'package:coofit/provider/favorite_provider.dart';
import 'package:coofit/style/style.dart';
import 'package:coofit/widgets/footer.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DetailPage extends StatefulWidget {

  static const routeName = '/detail_page';
  final String menuId;

  const DetailPage({Key? key, required this.menuId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {

  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<DetailProvider>(context, listen: false)
          .getMenuDetail(widget.menuId);
      Provider.of<FavoriteProvider>(context, listen: false)
          .favoriteValidator(widget.menuId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Consumer<DetailProvider>(
          builder: (context, value, child) {
            switch (value.state) {
              case RequestState.Success: {
                flickManager = FlickManager(
                  videoPlayerController: VideoPlayerController.network(
                    value.menu.videoUrl
                  )
                );
                return Row(
                  children: [
                    Expanded(
                      child: _buildMenuDetail(value.menu),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: _buildMenuSupport(),
                    )
                  ],
                );
              }
              case RequestState.Default:
                return Container();
              case RequestState.Empty:
                return Container();
              case RequestState.Loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.Error:
                return Center(
                  child: Text(value.message),
                );
            }
          }
        ),
      ),
    );
  }

  Widget _buildMenuDetail(MenuResponse menu) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: coofitTextTheme.bodyText1,
          ),
          const SizedBox(height: 4.0),
          Text(
            "${menu.description} \nKalori yang dihasilkan oleh ${menu.title} adalah sekitar ${menu.calories} kal",
            style: coofitTextTheme.subtitle2,
          ),
          const SizedBox(height: 24.0),
          Text(
            'Ingredients',
            style: coofitTextTheme.bodyText1,
          ),
          const SizedBox(height: 4.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menu.ingredients.length,
            itemBuilder: (context, index) {
              return _buildIngredientsItem(menu.ingredients[index]);
            },
          ),
          const SizedBox(height: 24.0),
          Text(
            'Steps',
            style: coofitTextTheme.bodyText1,
          ),
          const SizedBox(height: 4.0),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: menu.steps.length,
            itemBuilder: (context, index) {
              return _buildStepsItem(menu.steps[index], (index + 1));
            },
          ),
          const SizedBox(height: 24.0),
          Text(
            'Reviews',
            style: coofitTextTheme.bodyText1,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: menu.reviews.length,
              itemBuilder: (context, index) {
                return _buildReviewItem(menu.reviews[index]);
              }
          )
        ],
      ),
    );
  }

  Widget _buildMenuSupport() {
      return Center(
        child: Wrap(
          children: [Card(
            elevation: 8,
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VisibilityDetector(
                    key: ObjectKey(flickManager),
                    onVisibilityChanged: (visibility) {
                      if (visibility.visibleFraction == 0 && mounted) {
                        flickManager.flickControlManager?.autoPause();
                      } else if (visibility.visibleFraction == 1) {
                        flickManager.flickControlManager?.autoResume();
                      }
                    },
                    child: FlickVideoPlayer(
                      flickManager: flickManager,
                      flickVideoWithControls: const FlickVideoWithControls(
                        controls: FlickPortraitControls(),
                      ),
                      flickVideoWithControlsFullscreen: const FlickVideoWithControls(
                        controls: FlickLandscapeControls(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Consumer<FavoriteProvider>(
                    builder: (context, value, child) {
                      return MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: (value.state == RequestState.Loading)
                            ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(color: Colors.white)
                            ],
                            )
                            : (value.isFavorite)
                              ? Expanded(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(cupertinoIconFavorite, color: Colors.white),
                                      SizedBox(width: 16.0),
                                      Text('Remove From Favorite', style: TextStyle(color: Colors.white))
                                    ],
                             ),
                              )
                              : Expanded(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(cupertinoIconNotFavorite, color: Colors.white),
                                      SizedBox(width: 16.0),
                                      Text('Add To Favorite', style: TextStyle(color: Colors.white))
                                   ],
                            ),
                              ),
                        ),
                      onPressed: () {
                        final favoriteBody = FavoriteBody(menuId: widget.menuId);
                        if(value.isFavorite) {
                          value.deleteFavorite(favoriteBody);
                        } else {
                          value.addNewFavorites(favoriteBody);
                        }
                      },
                      color: primaryColor,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ]
        ),
      );
  }

  Widget _buildIngredientsItem(String ingredient) {
    return Flexible(
      child: Row(
        children: [
          const Icon(Icons.circle, color: primaryColor),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              ingredient,
              style: coofitTextTheme.subtitle2,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStepsItem(String step, int position) {
    return Flexible(
      child: Row(
        children: [
          Text(
            "$position.",
            style: coofitTextTheme.subtitle2,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              step,
              style: coofitTextTheme.subtitle2,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReviewItem(ReviewResponse review) {
    return SizedBox(
      height: 72,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(review.avatar),
                  ),
                  const SizedBox(width: 8),
                  Text(review.name)
                ],
              ),
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
                      review.rating.toString()
                  )
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_search/providers/audiovisual_single_provider.dart';
import 'package:movie_search/providers/audiovisuales_provider.dart';
import 'package:movie_search/ui/widgets/hex_color.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_search/ui/widgets/theme_switcher.dart';
import 'package:provider/provider.dart';

import '../widgets/default_image.dart';

class AudiovisualDetail extends StatefulWidget {
  final bool trending;

  const AudiovisualDetail({Key key, this.trending}) : super(key: key);

  @override
  _AudiovisualDetailState createState() => _AudiovisualDetailState();
}

class _AudiovisualDetailState extends State<AudiovisualDetail> {
  AudiovisualProvider audiovisualProvider;

  @override
  void initState() {
    super.initState();
    audiovisualProvider = Provider.of<AudiovisualProvider>(context, listen: false);
    Future.delayed(Duration(milliseconds: 100), () {
      audiovisualProvider.checkImageCached();
      if (widget.trending ?? false)
        audiovisualProvider.findMyDataTrending(context);
      else
        audiovisualProvider.findMyData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
//      padding: MediaQuery.of(context).padding.copyWith(left: 0, right: 0, bottom: 0),
//      color: Colors.white,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: getAppBar(context),
                ),
              )
            ],
            body: Container(
//            color: Colors.white,
              child: CustomScrollView(
                slivers: <Widget>[getContent()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverPadding getContent() => SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(<Widget>[
          Consumer<AudiovisualProvider>(
              builder: (context, snapshot, _) =>
                  snapshot.data == null ? LinearProgressIndicator() : Container()),
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Consumer<AudiovisualProvider>(
                builder: (context, audiovisualProvider, child) => Column(
                  children: <Widget>[
                    Hero(
                      tag: 'title-${audiovisualProvider.id}',
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          audiovisualProvider.title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                    AudiovisualContentHorizontal(
                        label: 'Sinópsis', content: audiovisualProvider.data?.sinopsis),
                    buildDivider(audiovisualProvider.data?.genre),
                    AudiovisualContentHorizontal(
                        label: 'Género', content: audiovisualProvider.data?.genre),
                    buildDivider(audiovisualProvider.voteAverage?.toString() ??
                        audiovisualProvider.data?.score),
                    AudiovisualContentHorizontal(
                        label: 'Valoracion',
                        content: audiovisualProvider.voteAverage?.toString() ??
                            audiovisualProvider.data?.score),
                    buildDivider(audiovisualProvider.data?.pais),
                    AudiovisualContentHorizontal(
                        label: 'Pais', content: audiovisualProvider.data?.pais),
                    buildDivider(audiovisualProvider.data?.director),
                    AudiovisualContentHorizontal(
                        label: 'Director', content: audiovisualProvider.data?.director),
                    buildDivider(audiovisualProvider.data?.capitulos),
                    AudiovisualContentHorizontal(
                        label: 'Guión', content: audiovisualProvider.data?.capitulos),
                    buildDivider(audiovisualProvider.data?.temp),
                    AudiovisualContentHorizontal(
                        label: 'Temporadas', content: audiovisualProvider.data?.temp),
                    buildDivider(audiovisualProvider.data?.anno),
                    AudiovisualContentHorizontal(
                        label: 'Año', content: audiovisualProvider.data?.anno),
                    buildDivider(audiovisualProvider.data?.productora),
                    AudiovisualContentHorizontal(
                        label: 'Productora', content: audiovisualProvider.data?.productora),
                    buildDivider(audiovisualProvider.data?.duracion),
                    AudiovisualContentHorizontal(
                        label: 'Duración', content: audiovisualProvider.data?.duracion),
                    buildDivider(audiovisualProvider.data?.idioma),
                    AudiovisualContentHorizontal(
                        label: 'Idioma', content: audiovisualProvider.data?.idioma),
                    buildDivider(audiovisualProvider.data?.reparto),
                    AudiovisualContentHorizontal(
                        label: 'Reparto', content: audiovisualProvider.data?.reparto),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ));

  Future<bool> onLikeButtonTap(bool isLiked, BuildContext context) {
    final ScaffoldState scaffoldState = context.findRootAncestorStateOfType<ScaffoldState>();
    if (scaffoldState != null) {
      scaffoldState.showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text(isLiked ? 'Eliminado de Mis Favoritos' : 'Agregado a Mis Favoritos'),
      ));
    }
    return audiovisualProvider.toggleFavourite(context: context);
  }

  Color getRatingColor(String score) {
    try {
      var d = double.parse(score);
      if (d < 6) {
        return Colors.redAccent;
      } else if (d < 9) {
        return Colors.yellowAccent;
      }
      return Colors.greenAccent;
    } catch (e) {
      return Theme.of(context).primaryColor;
    }
  }

  SliverAppBar getAppBar(BuildContext context) => SliverAppBar(
        pinned: true,
        floating: true,
        backgroundColor: HexColor('#252525'),
        elevation: 5,
        expandedHeight: MediaQuery.of(context).size.height * 0.6,
        primary: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          Consumer<AudiovisualProvider>(
            builder: (_, audiovisualProvider, child) => CircleAvatar(
              backgroundColor: getRatingColor(
                      audiovisualProvider.voteAverage?.toString() ?? audiovisualProvider.data?.score)
                  .withOpacity(0.5),
              child: Text(
                audiovisualProvider.voteAverage?.toString() ??
                    audiovisualProvider.data?.score ??
                    '-',
                style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.white70),
              ),
            ),
          ),
          likeButton(context),
          MyEasyDynamicThemeBtn()
        ],
        actionsIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: false,
              background: Consumer<AudiovisualProvider>(
                  builder: (ctx, av, child) => Hero(
                        tag: av.id,
                        child: Material(
                          color: Colors.black54,
                          child: GestureDetector(
                            onTap: () => previewImageDialog(context, av.imageUrl),
                            child: CachedNetworkImage(
                              imageUrl: av.imageUrl ?? av.data.image,
                              color: Colors.black54,
                              colorBlendMode: BlendMode.darken,
                              placeholder: (_, __) => Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (ctx, _, __) =>
                                  PlaceholderImage(heigth: MediaQuery.of(ctx).size.height * 0.6),
                              fit: BoxFit.cover,
//                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      )),
            );
          },
        ),
      );

  Widget likeButton(BuildContext context) =>
      Consumer<AudiovisualProvider>(builder: (ctx, av, child) {
        final fav = av.isFavourite ?? false;
        return IconButton(
          icon: Icon(fav ? Icons.favorite : Icons.favorite_border),
          color: fav ? Colors.red : Colors.white,
          onPressed: () {
            return onLikeButtonTap(fav, context);
          },
        );
      });

  Widget buildDivider(String value) {
    return Visibility(
      visible: value != null && value.isNotEmpty && value != 'N/A',
      child: Container(
//        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: Divider(
            height: 1,
//            color: Colors.black,
          ),
        ),
      ),
    );
  }

  previewImageDialog(BuildContext context, String imageUrl) {
    showDialog(
        context: context,
        builder: (context) => MediaQuery.removeViewInsets(
              removeLeft: true,
              removeTop: true,
              removeRight: true,
              removeBottom: true,
              context: context,
              child: AlertDialog(
                title: ListTile(
                  contentPadding: EdgeInsets.zero,
                  trailing: CircleAvatar(
//                backgroundColor: Colors.white70,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      iconSize: 24,
                      color: Colors.black87,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                elevation: 0,
                backgroundColor: Colors.black54,
                content: Builder(builder: (context) {
                  var height = MediaQuery.of(context).size.height;
                  return Container(
                    height: height - 20,
                    width: double.infinity,
                    child: ExtendedImage.network(
                      imageUrl,
                      fit: BoxFit.fitWidth,
                      //enableLoadState: false,
                      mode: ExtendedImageMode.gesture,
                      initGestureConfigHandler: (state) => GestureConfig(
                        minScale: 0.9,
                        animationMinScale: 0.7,
                        maxScale: 3.0,
                        animationMaxScale: 3.5,
                        speed: 1.0,
                        inertialSpeed: 100.0,
                        initialScale: 0.9,
                        inPageView: true,
                        initialAlignment: InitialAlignment.center,
                      ),
                    ),
                  );
                }),
              ),
            ));
  }
}

class AudiovisualContentHorizontal extends StatelessWidget {
  final String label;
  final String content;

  const AudiovisualContentHorizontal({Key key, this.label, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: content != null && content.isNotEmpty && content != 'N/A',
      child: Container(
//        color: Colors.white,
        child: ListTile(
          title: Text(label, style: Theme.of(context).textTheme.headline6),
          subtitle: Text(content != null && content.isNotEmpty ? content : '',
              style: Theme.of(context).textTheme.subtitle2),
        ),
      ),
    );
  }
}

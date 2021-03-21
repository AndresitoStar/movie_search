import 'package:flutter/material.dart';

import 'dart:io';
import 'package:http/http.dart' show get;
import 'package:movie_search/ui/icons.dart';
import 'package:movie_search/ui/widgets/circular_button.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked/stacked.dart';
import 'package:movie_search/providers/util.dart';

class ImageDownloadViewModel extends BaseViewModel {}

class ImageDownloadButton extends StatelessWidget {
  final String imgUrl;
  final String imageName;

  const ImageDownloadButton(this.imgUrl, this.imageName, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ImageDownloadViewModel>.reactive(
      builder: (context, model, child) => Platform.isWindows
          ? model.isBusy
              ? CircularProgressIndicator(strokeWidth: 1)
              : model.hasError
                  ? MyCircularButton(
                      icon: Icon(MyIcons.error, color: Colors.red))
                  : MyCircularButton(
                      icon: Icon(MyIcons.download),
                      color: Theme.of(context).accentColor,
                      onPressed: () => _downloadImage(context, model),
                    )
          : Container(),
      viewModelBuilder: () => ImageDownloadViewModel(),
    );
  }

  Future _downloadImage(
      BuildContext context, ImageDownloadViewModel model) async {
    try {
      model.setBusy(true);
      final response = await get(Uri.parse(imgUrl));
      final documentDirectory = File(Platform.script.toFilePath()).parent;

      final imageName = DateTime.now().microsecondsSinceEpoch;
      File file = new File(join(documentDirectory.path, '$imageName.png'));

      file.writeAsBytesSync(response.bodyBytes);
      context.scaffoldMessenger.showSnackBar(
        SnackBar(
          duration: Duration(seconds: 5),
          content: Text('Imagen descargada exitosamente.'),
          action: SnackBarAction(
            label: 'Abrir',
            onPressed: () => OpenFile.open(file.path),
          ),
        ),
      );
    } catch (err) {
      model.setError(err);
      context.showSnackbar('Ocurrio un error descargando la imagen.');
    }
    model.setBusy(false);
  }
}

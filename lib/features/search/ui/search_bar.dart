import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_search/common/extensions/context_extensions.dart';
import 'package:movie_search/common/ui/icons.dart';
import 'package:movie_search/features/search/provider/search_provider.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SearchBar extends ConsumerWidget {
  final String? hint;
  final FormGroup form = FormGroup({
    FORM_QUERY: FormControl<String>(value: ''),
    'filter': FormGroup({
      FORM_TYPE: FormControl<String>(value: 'all'),
      FORM_GENRE: FormControl<Set<String>>(value: {}),
      FORM_CAST: FormControl<Set<String>>(value: {}),
    }),
  });

  SearchBar({super.key, this.hint});

  FormControl<String> get queryControl => form.controls[FORM_QUERY] as FormControl<String>;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    queryControl.valueChanges.listen((value) {
      ref.read(searchProvider.notifier).onQueryChanged(value ?? '');
    });
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 0,
      color: context.theme.inputDecorationTheme.fillColor,
      child: ReactiveForm(
        formGroup: form,
        child: ReactiveTextField(
          formControl: queryControl,
          cursorColor: context.theme.colorScheme.onSurface,
          autocorrect: false,
          style: TextStyle(color: context.theme.colorScheme.onSurface),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: Icon(MyIcons.search, size: 16),
            hintText: hint ?? 'Buscar una película, serie, persona...',
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(MyIcons.clear),
                  color: context.theme.iconTheme.color,
                  onPressed: () {
                    queryControl.updateValue('', emitEvent: true);
                  },
                ),
                // IconButton(
                //   icon: Icon(Icons.send),
                //   color: context.theme.iconTheme.color,
                //   onPressed: () => search(),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const String FORM_QUERY = 'formQuery';
  static const String FORM_TYPE = 'type';
  static const String FORM_GENRE = 'genre';
  static const String FORM_CAST = 'cast';
}

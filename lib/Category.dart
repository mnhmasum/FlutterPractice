// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// @required is defined in the meta.dart package
import 'package:meta/meta.dart';

import 'CategoryBloc.dart';
import 'CategoryRoute.dart';
import 'TimeLine.dart';
import 'main.dart';

// We use an underscore to indicate that these variables are private.
// See https://www.dartlang.org/guides/language/effective-dart/design#libraries
final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.

class Category extends StatefulWidget {
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;

  const Category({
    Key key,
    @required
    @required this.name,
    @required this.color,
    @required this.iconLocation,
  }) : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CategoryItem(name: name, color: color, iconLocation: iconLocation);
  }
}

class CategoryItem extends State<Category> {
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;

  CategoryItem({
    Key key,
    @required this.name,
    @required this.color,
    @required this.iconLocation,
  })  : assert(name != null),
        assert(color != null),
        assert(iconLocation != null);


  /// Builds a custom widget that shows [Category] information.
  ///
  /// This information includes the icon, name, and color for the [Category].
  @override
  // This `context` parameter describes the location of this widget in the
  // widget tree. It can be used for obtaining Theme data from the nearest
  // Theme ancestor in the tree. Below, we obtain the display1 text theme.
  // See https://docs.flutter.io/flutter/material/Theme-class.html
  Widget build(BuildContext context) {

    //final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    final CategoryBloc _counterBloc = BlocProvider.of<CategoryBloc>(context);


    return Material(
      color: Colors.transparent,
      child: BlocBuilder<CategoryBloc, int>(
          builder: ( context, snapshot) {
            return Container(
              height: _rowHeight,
              child: InkWell(
                borderRadius: _borderRadius,
                highlightColor: color,
                splashColor: color,
                // We can use either the () => function() or the () { function(); }
                // syntax.
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimeLine()),
                  );

                  _counterBloc.setMyVal(30);
                  _counterBloc.dispatch(CategoryEvent.increment);
                  print('I was tapped! $snapshot');
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    // There are two ways to denote a list: `[]` and `List()`.
                    // Prefer to use the literal syntax, i.e. `[]`, instead of `List()`.
                    // You can add the type argument if you'd like, i.e. <Widget>[].
                    // See https://www.dartlang.org/guides/language/effective-dart/usage#do-use-collection-literals-when-possible
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Icon(
                          iconLocation,
                          size: 60.0,
                        ),
                      ),
                      Center(
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

      )

    );
  }
}
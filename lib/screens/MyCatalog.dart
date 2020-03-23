import 'package:cart_app/models/CartModel.dart';
import 'package:cart_app/models/CatalogModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) => _MyListItem(index),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;
  _MyListItem(this.index, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var catalog = Provider.of<CatalogModel>(context);
    var item = catalog.getByPosition(index);
    var textTheme = Theme.of(context).textTheme.title;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: SlideableListItem(
          item: item,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: item.color
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: Text(item.name, style: textTheme),
              ),
              SizedBox(width: 24),
              _AddButton(item: item)
            ],
          ),
        ),
      ),
    );
  }
}

class SlideableListItem extends StatelessWidget {
  final Widget child;
  final item;
  const SlideableListItem({Key key, @required this.child, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return Slidable(
      enabled: cart.has(item),
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.20,
      child: Container(
        color: Colors.white,
        child: child,
      ),
      actions: <Widget>[],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () { cart.remove(item); _showSnackBar(context, 'Deleted'); },
        ),
      ],
    );
  }

  _showSnackBar(BuildContext context, String s) {
    Scaffold.of(context).showSnackBar(
        SnackBar(content: Text(s))
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return FlatButton(
      onPressed: cart.items.contains(item)? null: () => cart.add(item),
      splashColor: Theme.of(context).primaryColor,
      child: cart.items.contains(item)? Icon(Icons.check, semanticLabel: 'ADDED'): Text('ADD'),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.display1),
      floating: true,
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        )
      ],
    );
  }
}



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:zartech/home/home_bloc.dart';
import 'package:zartech/home/home_event.dart';
import 'package:zartech/home/home_state.dart';
import 'package:zartech/home/models/item_carts.dart';
import 'package:zartech/home/models/list_resp.dart';

import '../base/app_theme.dart';
import '../carticon/cart_widget.dart';
import '../products/products_page.dart';
import 'nav_bar.dart';

final String tag = 'HomePage';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeBloc bloc = HomeBloc();

  @override
  void initState() {
    bloc.add(GetData());
    print('initState ***** ');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build $tag');
    return BlocProvider(
      create: (_) => bloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          print('listener BlocListener $tag');
          if (state is HomeError) {}
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: getAppTheme(),
          home: Scaffold(
            drawerEnableOpenDragGesture: true,
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              leading: InkWell(
                onTap: () {
                  print('leading icon clicked');
                  // _scaffoldKey.currentState?.openEndDrawer();
                  // _scaffoldKey.currentState?.openDrawer();
                  Scaffold.of(context).openDrawer();
                },
                child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Image.asset('assets/images/ic_menu.png')),
              ),
              leadingWidth: 120,
              actions: [
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) {
                    print('CartWidget previous -->>> $previous $tag');
                    print('CartWidget current -->>> $current $tag');
                    return current is CartChanged;
                  },
                  builder: (context, state) {
                    print('CartWidget state -->>> $state $tag');
                    if (state is CartChanged) {
                      return CartWidget(state.cartList!);
                    } else {
                      return CartWidget(<ItemCart>[]);
                    }
                  },
                )
              ],
            ),
            drawer: NavBar(),
            body: BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (previous, current) =>
                  (previous is HomeLoading) && (current is HomeLoaded),
              builder: (context, state) {
                print('BlocBuilder state --> $state  $tag');
                if (state is HomeLoading) {
                  print('***** -->> HomeLoading $tag');
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeError) {
                  print('HomeError $tag');
                  return const Center(
                      child: Text('Oops something went wrong!'));
                } else if (state is HomeLoaded) {
                  return HomeList(state.list[0].tableMenuList!);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HomeList extends StatelessWidget {
  const HomeList(
    this.tableMenuList, {
    Key? key,
  }) : super(key: key);

  final List<TableMenuList> tableMenuList;

  @override
  Widget build(BuildContext context) {
    print('build');
    return getPageView(context, tableMenuList);
  }

  Container getPageView(BuildContext context, List<TableMenuList> list) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: list.length,
              child: Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size(double.infinity, 60),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        boxShadow: [
                          const BoxShadow(
                            color: Color(0xF8404040),
                            offset: Offset(
                              0.0,
                              1.9,
                            ),
                            blurRadius: 3.0,
                          )
                        ]),
                    child: TabBar(
                      unselectedLabelColor: Colors.black45,
                      labelColor: Colors.red,
                      isScrollable: true,
                      indicatorColor: Theme.of(context).colorScheme.secondary,
                      tabs: getTabs(list),
                    ),
                  ),
                ),
                body: TabBarView(children: getPages(list)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

List<Widget> getPages(List<TableMenuList> list) {
  var temp = <Widget>[];
  for (var element in list) {
    var item = ProductsPage(element);
    temp.add(item);
  }
  return temp;
}

List<Tab> getTabs(List<TableMenuList> list) {
  var temp = <Tab>[];
  for (var element in list) {
    var item = Tab(text: element.menuCategory);
    temp.add(item);
  }
  return temp;
}

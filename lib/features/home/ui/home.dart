import 'package:bloc_flutter/features/cart/ui/cart.dart';
import 'package:bloc_flutter/features/home/bloc/home_bloc.dart';
import 'package:bloc_flutter/features/home/ui/product_tile_widget.dart';
import 'package:bloc_flutter/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBlock.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBlock = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBlock,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wishlist()));

        }

        else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Carted')));
        }
        else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item Wishlisted')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(body: Center(
              child: CircularProgressIndicator(),
            ),);
            break;

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Grocery App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBlock.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBlock.add(HomeCartButtonNavigationEvent());
                      },
                      icon: Icon(Icons.shopping_bag_outlined))
                ],
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                return ProductTileWidget(
                  homeBloc: homeBlock,
                    productDataModel: successState.products[index]);
              }),
            );

          case HomeErrorState:
            return Scaffold(body: Center(child: Text('error'),),);
          default:
            return SizedBox();
        }
      },
    );
  }
}



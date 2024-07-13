import 'package:bloc_flutter/features/home/bloc/home_bloc.dart';
import 'package:bloc_flutter/features/home/models/home_product_data_model.dart';
import 'package:flutter/material.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final HomeBloc homeBloc;
  const ProductTileWidget({super.key, required this.productDataModel, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(productDataModel.imageUrl),
                fit: BoxFit.cover
              )
            ),
          ),
          Text(productDataModel.name),
          Text(productDataModel.description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$ ' + productDataModel.price),

              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWishlistButtonClickedEvent(
                          clickedProduct: productDataModel
                        ));
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductCartButtonClickedEvent(
                          clickedProduct: productDataModel
                        ));
                      },
                      icon: Icon(Icons.shopping_bag_outlined))

                ],
              )
            ],
          )

        ],
      ),
    );
  }
}

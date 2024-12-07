import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../fav_cubit.dart';
import '../fav_state.dart';


class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: BlocProvider(
        create: (context) => FavoritesCubit()..fetchFavorites(),
        child: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FavoritesFailureState) {
              return Center(
                child: Text(
                  state.errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else if (state is FavoritesSuccessState) {
              final favorites = state.favorites;
              if (favorites.isEmpty) {
                return Center(child: Text("No Favorites Found"));
              }
              return ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final product = favorites[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        product.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name),
                      subtitle: Text("${product.price} جنيه"),
                    ),
                  );
                },
              );
            }
            return Center(child: Text("Something went wrong!"));
          },
        ),
      ),
    );
  }
}

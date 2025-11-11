import 'package:a2sv_project/data/models/country_summary_model.dart';
import 'package:a2sv_project/presentation/home/cubit/home_cubit.dart';
import 'package:a2sv_project/presentation/home/cubit/home_state.dart';
import 'package:a2sv_project/presentation/shared_widgets/country_list_tile.dart';
import 'package:a2sv_project/presentation/shared_widgets/tile_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Favourites'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoaded) {
            final List<CountrySummary> favouriteCountries = state.allCountries
                .where((c) => c.isFavourite)
                .toList();

            if (favouriteCountries.isEmpty) {
              return const Center(child: Text('No favourite countries yet.'));
            }

            return ListView.builder(
              itemCount: favouriteCountries.length,
              itemBuilder: (context, index) {
                final country = favouriteCountries[index];
                return AppListTile(
                  country: country,
                  style: TileStyle.favourite,
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

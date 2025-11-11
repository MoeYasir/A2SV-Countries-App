import 'package:a2sv_project/core/di/service_locator.dart';
import 'package:a2sv_project/presentation/home/cubit/home_cubit.dart';
import 'package:a2sv_project/presentation/home/cubit/home_state.dart';
import 'package:a2sv_project/presentation/shared_widgets/country_list_shimmer.dart';
import 'package:a2sv_project/presentation/shared_widgets/country_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Countries'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: BlocProvider(
        create: (context) => sl<HomeCubit>()..fetchAllCountries(),
        // --- THE FIX IS HERE ---
        // Use a Builder to get a context that is a descendant of the BlocProvider.
        child: Builder(
          builder: (context) {
            // This 'context' can now find the HomeCubit.
            return Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) {
                      // This now works perfectly!
                      context.read<HomeCubit>().searchCountry(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for a country',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                // The List
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeInitial || state is HomeLoading) {
                        return const CountryListShimmer();
                      }

                      if (state is HomeLoaded) {
                        if (state.filteredCountries.isEmpty) {
                          return const Center(
                            child: Text(
                              'No countries found.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: state.filteredCountries.length,
                          itemBuilder: (context, index) {
                            final country = state.filteredCountries[index];
                            return CountryListTile(country: country);
                          },
                        );
                      }

                      if (state is HomeError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(state.message),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<HomeCubit>().fetchAllCountries();
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

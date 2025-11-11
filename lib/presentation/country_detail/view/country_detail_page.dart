import 'package:a2sv_project/core/di/service_locator.dart';
import 'package:a2sv_project/presentation/country_detail/cubit/country_detail_cubit.dart';
import 'package:a2sv_project/presentation/country_detail/cubit/country_detail_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryDetailPage extends StatelessWidget {
  final String countryCode;

  const CountryDetailPage({super.key, required this.countryCode});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CountryDetailCubit>()..fetchCountryDetails(countryCode),
      child: BlocBuilder<CountryDetailCubit, CountryDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                state is CountryDetailLoaded ? state.country.name : '',
              ),
            ),
            body: buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget buildBody(BuildContext context, CountryDetailState state) {
    if (state is CountryDetailLoading || state is CountryDetailInitial) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is CountryDetailError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.message),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<CountryDetailCubit>().fetchCountryDetails(
                  countryCode,
                );
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (state is CountryDetailLoaded) {
      final country = state.country;
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Large Flag Image
            SizedBox(
              height: 250,
              width: double.infinity,
              child: country.flagUrl.endsWith('.svg')
                  ? SvgPicture.network(country.flagUrl, fit: BoxFit.cover)
                  : CachedNetworkImage(
                      imageUrl: country.flagUrl,
                      fit: BoxFit.cover,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Key Statistics Section
                  Text(
                    'Key Statistics',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildStatisticRow(
                    'Population:',
                    country.population.toString(),
                  ),
                  _buildStatisticRow('Region:', country.region),
                  _buildStatisticRow('Capital:', country.capital),
                  _buildStatisticRow('Subregion:', country.subregion),
                  _buildStatisticRow('Area:', '${country.area} km²'),
                  const Divider(height: 32),

                  // Timezone Section
                  Text(
                    'Timezone',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildStatisticRow(
                    'Timezones:',
                    country.timezones.join(', '),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildStatisticRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

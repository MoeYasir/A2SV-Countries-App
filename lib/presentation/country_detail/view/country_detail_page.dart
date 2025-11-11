import 'package:a2sv_project/core/di/service_locator.dart';
import 'package:a2sv_project/core/utils/formatter.dart';
import 'package:a2sv_project/presentation/country_detail/cubit/country_detail_cubit.dart';
import 'package:a2sv_project/presentation/country_detail/cubit/country_detail_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          final countryName = state is CountryDetailLoaded
              ? state.country.name
              : '';
          return Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              title: Text(
                countryName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.h,
              foregroundColor: Colors.black87, // Make back arrow visible
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
            SizedBox(height: 16.sp),
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: countryCode,
              child: SizedBox(
                height: 400.h,

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0.r),
                  child: country.flagUrl.endsWith('.svg')
                      ? SvgPicture.network(country.flagUrl, fit: BoxFit.cover)
                      : CachedNetworkImage(
                          imageUrl: country.flagUrl,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            Padding(
              padding: EdgeInsets.all(12.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key Statistics',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildStatisticRow('Area', formatArea(country.area)),
                  _buildStatisticRow(
                    'Population',
                    formatPopulationWithWords(country.population),
                  ),
                  _buildStatisticRow('Region', country.region),
                  _buildStatisticRow('Sub Region', country.subregion),
                  SizedBox(height: 16.h),

                  Text(
                    'Timezone',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Wrap(
                    spacing: 8.0.w,
                    runSpacing: 8.0.w,
                    children: country.timezones
                        .map((tz) => _buildTimezoneChip(tz))
                        .toList(),
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
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.grey[600], fontSize: 16.sp),
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildTimezoneChip(String timezone) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 8.0.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(timezone, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

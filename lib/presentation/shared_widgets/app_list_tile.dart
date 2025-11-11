import 'package:a2sv_project/core/utils/formatter.dart';
import 'package:a2sv_project/data/models/country_summary_model.dart';
import 'package:a2sv_project/presentation/country_detail/view/country_detail_page.dart';
import 'package:a2sv_project/presentation/home/cubit/home_cubit.dart';
import 'package:a2sv_project/presentation/shared_widgets/tile_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class AppListTile extends StatelessWidget {
  final CountrySummary country;
  final TileStyle style;
  final bool isHeroEnabled;
  const AppListTile({
    super.key,
    required this.country,
    required this.style,
    this.isHeroEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final isFavouriteStyle = style == TileStyle.favourite;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountryDetailPage(countryCode: country.cca2),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: isFavouriteStyle ? null : _homeBoxDecoration(),
          child: Row(
            children: [
              _buildFlag(isFavouriteStyle),
              const SizedBox(width: 16),
              _buildTextBlock(context, isFavouriteStyle),
              _buildHeartIcon(context),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _homeBoxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  Widget _buildFlag(bool isFavouriteStyle) {
    final double size = isFavouriteStyle ? 60 : 75;
    final double width = isFavouriteStyle ? 60 : 100;

    return Hero(
      tag: isHeroEnabled ? country.cca2 : UniqueKey(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: SizedBox(
          width: width,
          height: size,
          child: country.flagUrl.endsWith('.svg')
              ? SvgPicture.network(
                  country.flagUrl,
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) =>
                      Container(color: Colors.grey[200]),
                )
              : CachedNetworkImage(
                  imageUrl: country.flagUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(color: Colors.grey[200]),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
        ),
      ),
    );
  }

  Widget _buildTextBlock(BuildContext context, bool isFavouriteStyle) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            country.name,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            isFavouriteStyle
                ? 'Capital: ${country.capital}'
                : 'Population: ${formatPopulation(country.population)}',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildHeartIcon(BuildContext context) {
    return IconButton(
      icon: Icon(
        country.isFavourite ? Icons.favorite : Icons.favorite_border,
        color: country.isFavourite ? Colors.red : Colors.grey,
      ),
      onPressed: () {
        context.read<HomeCubit>().toggleFavouriteStatus(country.cca2);
      },
    );
  }
}

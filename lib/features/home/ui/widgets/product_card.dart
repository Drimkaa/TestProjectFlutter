import 'package:flutter/material.dart';
import '../../domain/models/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,

      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black12, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Center(
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
          ),

          Container(
            height: 112,
            padding: EdgeInsets.only(left: 8, bottom: 8, right: 8),
            color: Theme.of(context).cardTheme.color,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 12),
                Text(
                  '${product.price.toStringAsFixed(2)} \₽',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.labelMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                if (product.rating != null)
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidStar,
                        size: 12,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        product.rating!.rate.toString(),

                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                      ),
                      const SizedBox(width: 12),
                      FaIcon(
                        FontAwesomeIcons.solidComments,
                        size: 12,
                        color: Colors.black45,
                      ),

                      const SizedBox(width: 4),
                      Text(
                        '${product.rating!.count} отзывов',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

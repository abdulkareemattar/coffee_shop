import 'package:coffee_shop/gen/assets.gen.dart';
import 'package:coffee_shop/models/coffee_model.dart';
import 'package:coffee_shop/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'coffee_card.dart';

class CoffeeGrid extends StatelessWidget {
  const CoffeeGrid({super.key});

  static final List<CoffeeModel> _coffeeList = [
    CoffeeModel(
      imagePath: Assets.images.property1CoffeeProperty21.path,
      name: 'Caffe Mocha',
      type: 'Deep Foam',
      price: 4.53,
      rating: 4.8,
      description:
          'A Caffe Mocha is a rich, chocolate-flavored variant of a latte. It is made with espresso, steamed milk, and chocolate syrup, often topped with whipped cream.',
    ),
    CoffeeModel(
      imagePath: Assets.images.property1CoffeeProperty22.path,
      name: 'Flat White',
      type: 'Espresso',
      price: 3.53,
      rating: 4.9,
      description:
          'A Flat White is an espresso-based coffee drink with steamed milk, originating from Australia and New Zealand. It is similar to a latte but with a higher coffee-to-milk ratio.',
    ),
    CoffeeModel(
      imagePath: Assets.images.property1CoffeeProperty23.path,
      name: 'Cappuccino',
      type: 'Steamed Milk',
      price: 4.20,
      rating: 4.7,
      description:
          'A Cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk. The foam on top is a key characteristic.',
    ),
    CoffeeModel(
      imagePath: Assets.images.property1CoffeeProperty24.path,
      name: 'Americano',
      type: 'Hot Water',
      price: 3.10,
      rating: 4.6,
      description:
          'An Americano is a type of coffee drink prepared by diluting an espresso with hot water, giving it a similar strength to, but different flavor from, traditionally brewed coffee.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 0.72,
      ),
      itemCount: _coffeeList.length,
      itemBuilder: (context, index) {
        final coffeeItem = _coffeeList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(coffeeModel: coffeeItem),
              ),
            );
          },
          child: CoffeeCard(
            imagePath: coffeeItem.imagePath,
            name: coffeeItem.name,
            type: coffeeItem.type,
            price: coffeeItem.price,
            rating: coffeeItem.rating,
          ),
        );
      },
    );
  }
}

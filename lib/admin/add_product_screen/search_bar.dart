import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/shared_widgets/colours.dart';
import 'package:shop_management/user/explore_screen/provider.dart';

class CustomSearchBar extends ConsumerWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController searchInput = TextEditingController();
    searchInput.text = ref.watch(inputProvider.notifier).state ?? '';
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: TextStyle(color: Colors.white),
            controller: searchInput,
            onSubmitted: (value) {
              ref.watch(inputProvider.notifier).state = value;
              ref.refresh(kproductStreamProvider);
              searchInput.text = value;
            },
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  ref.watch(inputProvider.notifier).state = null;
                  ref.refresh(kproductStreamProvider);
                  searchInput.clear();
                },
                icon: const Icon(
                  Icons.clear,
                  color: CustomColours.primaryBrown,
                ),
              ),
              hintText: 'Search...',
              labelStyle: const TextStyle(color: CustomColours.primaryBrown),
              hintStyle: const TextStyle(color: CustomColours.primaryBrown),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: CustomColours.primaryBrown,
              ),
            ),
            cursorColor: Colors.black,
          ),
        ),
      ],
    );
  }
}

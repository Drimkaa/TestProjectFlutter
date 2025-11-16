import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/features/home/ui/widgets/product_card.dart';
import '../vm/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<HomeViewModel>();
      vm.reset();
    });
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final vm = context.read<HomeViewModel>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (vm.hasMore && !vm.isLoading) {
        vm.loadMore();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Главная',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 3),
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, vm, _) {
          if (vm.products.isEmpty && vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.products.isEmpty && vm.error != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(vm.error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => vm.reset(),
                    child: const Text('Повторить'),
                  ),
                ],
              ),
            );
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(2),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    if (index == vm.products.length) {
                      return null;
                    }
                    final product = vm.products[index];
                    return ProductCard(product: product);
                  }, childCount: vm.products.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 4,
                    childAspectRatio: 0.52,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Center(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

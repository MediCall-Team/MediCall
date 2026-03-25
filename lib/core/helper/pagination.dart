typedef FetchPage<T> = Future<(List<T>, int)> Function(int pageIndex, int pageSize);

class PaginationHelper<T> {
  final FetchPage<T> fetchPage;
  final int pageSize;

  PaginationHelper({
    required this.fetchPage,
    this.pageSize = 10,
  });

  List<T> items = [];
  int pageIndex = 1;
  bool isLoading = false;
  bool hasMore = true;
  int totalCount = 0;

  void reset() {
    items.clear();
    pageIndex = 1;
    isLoading = false;
    hasMore = true;
    totalCount = 0;
  }

  Future<void> loadNextPage() async {
    if (isLoading || !hasMore) return;

    isLoading = true;

    try {
      final (newItems, count) = await fetchPage(pageIndex, pageSize);

      totalCount = count;

      items.addAll(newItems);

      if (items.length >= totalCount) {
        hasMore = false;
      } else {
        pageIndex++;
      }
    } finally {
      isLoading = false;
    }
  }

  bool get showShimmer => isLoading && hasMore;
}
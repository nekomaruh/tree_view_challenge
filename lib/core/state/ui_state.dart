class UiState<T> {
  final bool isLoading;
  final T? data;
  final String? error;

  UiState({
    required this.isLoading,
    this.data,
    this.error,
  });

  factory UiState.init() {
    return UiState(isLoading: true);
  }

  UiState<T> copyWith({
    bool? isLoading,
    T? data,
    String? error,
  }) {
    return UiState<T>(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}
import 'package:bloc/bloc.dart';
import 'package:grad_project/core/error/failure.dart';
import 'package:grad_project/core/helper/pagination.dart';
import 'package:grad_project/patient/features/home/categories/repo/categories_repo.dart';
import 'package:grad_project/patient/features/home/data/models/doctor_model.dart';
import 'package:meta/meta.dart';

part 'service_providers_list_state.dart';
class ServiceProvidersListCubit extends Cubit<ServiceProvidersListState> {
  ServiceProvidersListCubit({required this.repo})
      : super(ServiceProvidersListInitial());

  final CategoriesRepo repo;

  late PaginationHelper<DoctorModel> pagination;
 // late String specialty;


  String? specialty;
  int? gender;
  String? area;
  double? minPrice;
  double? maxPrice;
  String? search;

  void init(String specialty) {
    this.specialty = specialty;
    _initPagination();
    loadFirstPage();
  }

  void updateFilters({
    int? gender,
    String? area,
    double? minPrice,
    double? maxPrice,
    String? search,
  }) {
    this.gender = gender;
    this.area = area;
    this.minPrice = minPrice;
    this.maxPrice = maxPrice;
    this.search = search;

    loadFirstPage(); // 🔥 أهم خطوة
  }

  void _initPagination() {
    pagination = PaginationHelper<DoctorModel>(
      pageSize: 10,
      fetchPage: (pageIndex, pageSize) async {
        final result = await repo.getProvidersList(
          pageIndex: pageIndex,
          pageSize: pageSize,
          specialty: specialty ?? "",
          gender: gender,
          area: area,
          minPrice: minPrice,
          maxPrice: maxPrice,
          search: search,
        );

        return result.fold(
          (failure) => throw failure,
          (data) => data, // (list , count)
        );
      },
    );
  }



  // void init(String specialty) {
  //   this.specialty = specialty;

  //   pagination = PaginationHelper<DoctorModel>(
  //     pageSize: 10,
  //     fetchPage: (pageIndex, pageSize) async {
  //       final result = await repo.getProvidersList(
  //         pageIndex: pageIndex,
  //         pageSize: pageSize,
  //         specialty: specialty,
  //       );

  //       return result.fold(
  //         (failure) => throw failure,
  //         (data) => data, // (list , count)
  //       );
  //     },
  //   );

  //   loadFirstPage();
  // }

  Future<void> loadFirstPage() async {
    pagination.reset();
    emit(ServiceProvidersListLoading());

    try {
      await pagination.loadNextPage();

      emit(ServiceProvidersListSuccess(
        doctorSModelList: pagination.items,
        isLoadingMore: false,
      ));
    } catch (failure) {
      emit(ServiceProvidersListFaliure(
        errorMsg: (failure as Failure).errorMsg,
      ));
    }
  }

  Future<void> loadMore() async {
    if (!pagination.hasMore || pagination.isLoading) return;

    emit(ServiceProvidersListSuccess(
      doctorSModelList: pagination.items,
      isLoadingMore: true,
    ));

    try {
      await pagination.loadNextPage();

      emit(ServiceProvidersListSuccess(
        doctorSModelList: pagination.items,
        isLoadingMore: false,
      ));
    } catch (failure) {
      emit(ServiceProvidersListFaliure(
        errorMsg: (failure as Failure).errorMsg,
      ));
    }
  }
}
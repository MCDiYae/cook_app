
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_service.dart';
import '../models/category.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> getCategories() async {
    return await remoteDataSource.fetchCategories();
  }
}
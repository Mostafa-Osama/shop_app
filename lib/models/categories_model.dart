class CategoriesModel{
  bool status;
  CategoriesDataModel data;
   CategoriesModel.fromJson(Map<String,dynamic> jason){
     status = jason['status'];
     data = CategoriesDataModel.fromJson(jason['data']);
   }
}


class CategoriesDataModel{

  int currentPage;
  List<DataModel> data =[];
  String firstPageUrl ;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to ;
  int total;

  CategoriesDataModel.fromJson(Map<String,dynamic> jason){
    currentPage = jason['current_page'];
    firstPageUrl = jason['first_page_url'];
    from = jason['from'];
    lastPage = jason['last_page'];
    lastPageUrl = jason['last_page_url'];
    nextPageUrl = jason['next_page_url'];
    path = jason['path'];
    perPage = jason['per_page'];
    prevPageUrl = jason['prev_page_url'];
    to = jason['to'];
    total = jason['total'];

    jason['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }


}


class DataModel{
  int id;
  String name;
  String image;

  DataModel.fromJson(Map<String,dynamic> jason){
    id = jason['jd'];
    name = jason['name'];
    image = jason['image'];
  }
}
class CategoryModel {
  List<Books> books;
  String error;
  String errorMessage;
  Data data;

  CategoryModel({this.books, this.error, this.errorMessage, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['books'] != null) {
      books = new List<Books>();
      json['books'].forEach((v) {
        books.add(new Books.fromJson(v));
      });
    }
    error = json['error'];
    errorMessage = json['error_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.books != null) {
      data['books'] = this.books.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['error_message'] = this.errorMessage;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Books {
  String id;
  String cover;
  String pagesCount;
  String voteCount;
  String writer;
  String description;
  String name;
  String price;
  String language;
  String coverType;
  String pictureThumb;
  String picture;
  String salesCount;
  String isBanner;
  String categoryId;

  Books(
      {this.id,
      this.cover,
      this.pagesCount,
      this.voteCount,
      this.writer,
      this.description,
      this.name,
      this.price,
      this.language,
      this.coverType,
      this.pictureThumb,
      this.picture,
      this.salesCount,
      this.isBanner,
      this.categoryId});

  Books.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cover = json['cover'];
    pagesCount = json['pages_count'];
    voteCount = json['vote_count'];
    writer = json['writer'];
    description = json['description'];
    name = json['name'];
    price = json['price'];
    language = json['language'];
    coverType = json['cover_type'];
    pictureThumb = json['picture_thumb'];
    picture = json['picture'];
    salesCount = json['sales_count'];
    isBanner = json['is_banner'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['cover'] = this.cover;
    data['pages_count'] = this.pagesCount;
    data['vote_count'] = this.voteCount;
    data['writer'] = this.writer;
    data['description'] = this.description;
    data['name'] = this.name;
    data['price'] = this.price;
    data['language'] = this.language;
    data['cover_type'] = this.coverType;
    data['picture_thumb'] = this.pictureThumb;
    data['picture'] = this.picture;
    data['sales_count'] = this.salesCount;
    data['is_banner'] = this.isBanner;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class Data {
  int totalPages;
  String currentPage;
  int offsetPage;

  Data({this.totalPages, this.currentPage, this.offsetPage});

  Data.fromJson(Map<String, dynamic> json) {
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    offsetPage = json['offset_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_pages'] = this.totalPages;
    data['current_page'] = this.currentPage;
    data['offset_page'] = this.offsetPage;
    return data;
  }
}

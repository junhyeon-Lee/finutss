import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LikeQueries {
  static final LIKE_PAGINATE = gql(r'''
  query LikePaginate($page: Int, $limit: Int, $findQuery: JSON) {
    likePaginate(page: $page, limit: $limit, findQuery: $findQuery) {
      docs {
        ...LikeFragment
      }
      totalDocs
      limit
      page
      totalPages
      hasNextPage
      nextPage
      hasPrevPage
      prevPage
      pagingCounter
    }
  }
'''
      '''${Fragments.likeFragment}''');

  static final LIKE = gql(r'''
  query Like($id: ID) {
    like(id: $id) {
      ...LikeFragment
    }
  }
'''
      '''${Fragments.likeFragment}''');

  static final ADD_LIKE = gql(r'''
  mutation AddLike($data: InputLike) {
    addLike(data: $data) {
      ...LikeFragment
    }
  }
'''
      '''${Fragments.likeFragment}''');

  static final REMOVE_LIKE = gql(r'''
  mutation RemoveLike($id: ID!) {
    removeLike(id: $id)
  }
''');
}

import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommentQueries {
  static final COMMENT_PAGINATE = gql(r'''
  query CommentPaginate($page: Int, $limit: Int, $findQuery: JSON) {
    commentPaginate(page: $page, limit: $limit, findQuery: $findQuery) {
      docs {
        ...CommentFragment
        children {
          ...CommentFragment
        }
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
      '''${Fragments.commentFragment}''');

  static final COMMENT = gql(r'''
  query Comment($id: ID) {
    comment(id: $id) {
      ...CommentFragment
    }
  }
'''
      '''${Fragments.commentFragment}''');

  static final COMMENT_MY_CNT = gql(r'''
  query CommentMyCnt($user: ID) {
    commentMyCnt(user: $user)
  }
''');

  static final ADD_COMMENT = gql(r'''
  mutation AddComment($data: InputComment) {
    addComment(data: $data) {
      ...CommentFragment
    }
  }
'''
      '''${Fragments.commentFragment}''');

  static final UPDATE_COMMENT = gql(r'''
  mutation UpdateComment($id: ID!, $data: InputComment) {
    updateComment(id: $id, data: $data) {
      ...CommentFragment
    }
  }
'''
      '''${Fragments.commentFragment}''');

  static final REMOVE_COMMENT = gql(r'''
  mutation RemoveComment($id: ID!) {
    removeComment(id: $id)
  }
''');
}

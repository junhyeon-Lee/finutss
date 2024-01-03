import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DefaultQueries {
  static final POSTS = gql(r'''
  query Posts($page: Int, $limit: Int, $findQuery: JSON) {
    posts(page: $page, limit: $limit, findQuery: $findQuery) {
      docs {
        ...PostFragment
        created {
          ...UserFragment
        }
        updated {
          ...UserFragment
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
      '''${Fragments.postFragment}'''
      '''${Fragments.userFragment}''');

  static final POST = gql(r'''
  query Post($id: ID) {
    post(id: $id) {
      ...PostFragment
      created {
        ...UserFragment
      }
      updated {
        ...UserFragment
      }
    }
  }
'''
      '''${Fragments.postFragment}'''
      '''${Fragments.userFragment}''');

  static final POST_LIST = gql(r'''
  query PostList($findQuery: JSON) {
    postList(findQuery: $findQuery) {
      ...PostFragment
      created {
        ...UserFragment
      }
      updated {
        ...UserFragment
      }
    }
  }
'''
      '''${Fragments.postFragment}''');

  static final CHECK_NEW_POST = gql(r'''
  query CheckNewPost($boardType: String) {
    checkNewPost(boardType: $boardType)
  }
''');

  static final ADD_POST = gql(r'''
  mutation AddPost($data: InputPost) {
    addPost(data: $data) {
      ...PostFragment
    }
  }
'''
      '''${Fragments.postFragment}''');

  static final UPDATE_POST = gql(r'''
  mutation UpdatePost($id: ID!, $data: InputPost) {
    updatePost(id: $id, data: $data) {
      ...PostFragment
    }
  }
'''
      '''${Fragments.postFragment}''');

  static final REMOVE_POST = gql(r'''
  mutation RemovePost($id: ID!) {
    removePost(id: $id)
  }
''');
}

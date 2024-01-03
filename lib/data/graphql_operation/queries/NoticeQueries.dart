import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class NoticeQueries {
  static final NOTICE = gql(r'''
  query Notice($id: ID!) {
    notice(id: $id) {
      ...NoticeFragment
    }
  }
'''
      '''${Fragments.noticeFragment}''');

  static final NOTICES = gql(r'''
  query Notices($findQuery: JSON) {
    notices(findQuery: $findQuery) {
      ...NoticeFragment
    }
  }
'''
      '''${Fragments.noticeFragment}''');

  static final ADD_NOTICE = gql(r'''
  mutation AddNotice($data: InputNotice) {
    addNotice(data: $data) {
      ...NoticeFragment
    }
  }
'''
      '''${Fragments.noticeFragment}''');

  static final UPDATE_NOTICE = gql(r'''
  mutation UpdateNotice($id: ID!, $data: InputNotice) {
    updateNotice(id: $id, data: $data) {
      ...NoticeFragment
    }
  }
'''
      '''${Fragments.noticeFragment}''');

  static final REMOVE_NOTICE = gql(r'''
  mutation RemoveNotice($id: ID!) {
    removeNotice(id: $id)
  }
''');

  static final NOTICE_PAGINATE = gql(r'''
  query NoticePaginate(
    $sort: JSON
    $page: Int
    $limit: Int
    $findQuery: JSON
  ) {
    noticePaginate(
      sort: $sort
      page: $page
      limit: $limit
      findQuery: $findQuery
    ) {
      docs {
       ...NoticeFragment
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
      '''${Fragments.noticeFragment}''');
}

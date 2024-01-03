import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReportQueries {
  static final REPORT = gql(r'''
  query Report($id: ID!) {
    report(id: $id) {
      ...ReportFragment
    }
  }
'''
      '''${Fragments.reportFragment}''');

  static final REPORTS = gql(r'''
  query Reports($findQuery: JSON) {
    reports(findQuery: $findQuery) {
      ...ReportFragment
    }
  }
'''
      '''${Fragments.reportFragment}''');

  static final ADD_REPORT = gql(r'''
  mutation AddReport($data: InputReport) {
    addReport(data: $data) {
      ...ReportFragment
    }
  }
'''
      '''${Fragments.reportFragment}''');

  static final UPDATE_REPORT = gql(r'''
  mutation UpdateReport($id: ID!, $data: InputReport) {
    updateReport(id: $id, data: $data) {
      ...ReportFragment
    }
  }
'''
      '''${Fragments.reportFragment}''');

  static final REMOVE_REPORT = gql(r'''
  mutation RemoveReport($id: ID!) {
    removeReport(id: $id)
  }
''');

  static final REPORT_PAGINATE = gql(r'''
  query ReportPaginate(
    $sort: JSON
    $page: Int
    $limit: Int
    $findQuery: JSON
  ) {
    reportPaginate(
      sort: $sort
      page: $page
      limit: $limit
      findQuery: $findQuery
    ) {
      docs {
       ...ReportFragment
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
      '''${Fragments.reportFragment}''');
}

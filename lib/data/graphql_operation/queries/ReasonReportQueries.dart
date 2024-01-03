import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReasonReportQueries {
  static final REASON_REPORT = gql(r'''
  query ReasonReport($id: ID!) {
    reasonReport(id: $id) {
      ...ReasonReportFragment
    }
  }
'''
      '''${Fragments.reasonReportFragment}''');

  static final REASON_REPORTS = gql(r'''
  query ReasonReports($findQuery: JSON) {
    reasonReports(findQuery: $findQuery) {
      ...ReasonReportFragment
    }
  }
'''
      '''${Fragments.reasonReportFragment}''');

  static final ADD_REASON_REPORT = gql(r'''
  mutation AddReasonReport($data: InputReasonReport) {
    addReasonReport(data: $data) {
      ...ReasonReportFragment
    }
  }
'''
      '''${Fragments.reasonReportFragment}''');

  static final UPDATE_REASON_REPORT = gql(r'''
  mutation UpdateReasonReport($id: ID!, $data: InputReasonReport) {
    updateReasonReport(id: $id, data: $data) {
      ...ReasonReportFragment
    }
  }
'''
      '''${Fragments.reasonReportFragment}''');

  static final REMOVE_REASON_REPORT = gql(r'''
  mutation RemoveReasonReport($id: ID!) {
    removeReasonReport(id: $id)
  }
''');

  static final REASON_REPORT_PAGINATE = gql(r'''
  query ReasonReportPaginate(
    $sort: JSON
    $page: Int
    $limit: Int
    $findQuery: JSON
  ) {
    reasonReportPaginate(
      sort: $sort
      page: $page
      limit: $limit
      findQuery: $findQuery
    ) {
      docs {
       ...ReasonReportFragment
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
      '''${Fragments.reasonReportFragment}''');
}

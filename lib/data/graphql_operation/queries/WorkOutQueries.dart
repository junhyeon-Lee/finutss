import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class WorkOutQueries {
  static final IN_WORKOUT = gql(r'''
  query InWorkOut {
    inWorkOut {
      id
      writer {
        id
        nickName
        memo
        image {
          ...ImageFragment
        }
      }
    }
  }
'''
      '''${Fragments.imageFragment}''');

  static final WORKOUT = gql(r'''
  query WorkOut($id: ID!) {
    workOut(id: $id) {
      ...WorkOutFragment
    }
  }
'''
      '''${Fragments.workOutFragment}''');

  static final WORKOUT_TOTAL_OF_ALL = gql(r'''
  query WorkOutTotalOfAll($writer: ID!) {
    workOutTotalOfAll(writer: $writer) {
       all {
        kcal
        duration
        distance
        last
       }
       riding {
        kcal
        duration
        distance
        last
       }
       running {
        kcal
        duration
        distance
        last
       }
    }
  }
''');
  static final WORKOUT_TOTAL_OF_DAY = gql(r'''
  query WorkOutTotalOfDay($writer: ID!, $createdAt: JSON ) {
    workOutTotalOfDay(writer: $writer, createdAt: $createdAt) {
        kcal
        duration
        distance
        last
    }
  }
''');
  static final WORKOUT_BY_DAY_OF_WEEK = gql(r'''
  query WorkOutByDayOfWeek($writer: ID!, $createdAt: JSON ) {
    workOutByDayOfWeek(writer: $writer, createdAt: $createdAt) {
        _id {
          day
        }
        kcal
        duration
        distance
        last
    }
  }
''');

  static final WORKOUTS = gql(r'''
  query WorkOuts($findQuery: JSON) {
    workOuts(findQuery: $findQuery) {
      ...WorkOutFragment
    }
  }
'''
      '''${Fragments.workOutFragment}''');

  static final WORKOUT_PAGINATE = gql(r'''
  query WorkOutPaginate($page: Int, $limit: Int, $findQuery: JSON) {
    workOutPaginate(page: $page, limit: $limit, findQuery: $findQuery) {
      docs {
        ...WorkOutFragment
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
      '''${Fragments.workOutFragment}''');

  static final NEW_WORKOUT = gql(r'''
  subscription NewWorkOut($track: ID!) {
    newWorkOut(track: $track) {
      id
      phase
      writer {
        id
        image {
          url
        }
      }
    }
  }
''');

  static final ADD_WORKOUT = gql(r'''
  mutation addWorkOut($data: InputWorkOut) {
    addWorkOut(data: $data) {
      ...WorkOutFragment
    }
  }
'''
      '''${Fragments.workOutFragment}''');
  static final UPDATE_WORKOUT = gql(r'''
  mutation UpdateWorkOut($data: InputWorkOut) {
    updateWorkOut(data: $data)
  }
''');

  static final REMOVE_WORKOUT = gql(r'''
  mutation RemoveWorkOut($id: ID!) {
    removeWorkOut(id: $id)
  }
''');
  static final REMOVE_ALL_WORKOUT = gql(r'''
  mutation RemoveAllWorkOut($id: ID!) {
    removeAllWorkOut(id: $id)
  }
''');
}

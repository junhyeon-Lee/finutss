import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class TrackQueries {
  static final TRACK = gql(r'''
  query Track($id: ID!) {
    track(id: $id) {
      ...TrackFragment
    }
  }
'''
      '''${Fragments.trackFragment}''');

  static final TRACKS = gql(r'''
  query {
    getTracks {
        track_id
        title
        start_gpx_id
        end_gpx_id
        title
        description
        distance
        duration
        created_at
        updated_at
        gpx_start {
            gpx_id
            latitude
            longitude
        }
        gpx_end {
            gpx_id
            latitude
            longitude
        }
        workout {
          workout_id
          title
          description
          status
          track_id
          user_id
          kcal
          workout_type
          is_record
          created_at
          updated_at  
        }
    }
  }
''');

  static final ADD_TRACK = gql(r'''
  mutation AddTrack($data: InputTrack) {
    addTrack(data: $data) {
      ...TrackFragment
    }
  }
'''
      '''${Fragments.trackFragment}''');

  static final UPDATE_TRACK = gql(r'''
  mutation UpdateTrack($id: ID!, $data: InputTrack) {
    updateTrack(id: $id, data: $data) {
      ...TrackFragment
    }
  }
'''
      '''${Fragments.trackFragment}''');

  static final REMOVE_TRACK = gql(r'''
  mutation RemoveTrack($id: ID!) {
    removeTrack(id: $id)
  }
''');

  static final TRACK_PAGINATE = gql(r'''
  query TrackPaginate(
    $sort: JSON
    $page: Int
    $limit: Int
    $findQuery: JSON
  ) {
    trackPaginate(
      sort: $sort
      page: $page
      limit: $limit
      findQuery: $findQuery
    ) {
      docs {
       ...TrackFragment
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
      '''${Fragments.trackFragment}''');
}

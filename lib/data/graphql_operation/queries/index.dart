import 'package:graphql_flutter/graphql_flutter.dart';

class DefaultQueries {

  static final UPDATE_TOKEN = gql(r'''
  mutation($refreshToken: String!){
    updateTokenPair(refreshToken: $refreshToken) {
        accessToken
        accessTokenExpiresAt
        refreshToken
        refreshTokenExpiresAt
    }
  }
''');

  static final LOGIN = gql(r'''
  mutation authUser($data: InputAuth!) {
    authUser(authInfo: $data) {
        tokens  {
            accessToken
            accessTokenExpiresAt
            refreshToken
            refreshTokenExpiresAt
        }
    }
  }
''');

  static final LOGOUT = gql(r'''
  mutation {
    logout 
  }
''');

  static final META = gql(r'''
  query Meta($key: String!) {
    meta(key: $key) {
      key
      value
    }
  }
''');

  static final METAS = gql(r'''
  query Metas($keys: [String]) {
    metas(keys: $keys) {
      key
      value
    }
  }
''');

  static final METAS_REGEXP = gql(r'''
  query MetasRegexp($key: String!) {
    metasRegexp(key: $key) {
      key
      value
    }
  }
''');

  static final SAVE_META = gql(r'''
  mutation SaveMeta($key: String!, $data: InputMeta) {
    saveMeta(key: $key, data: $data) {
      key
      value
    }
  }
''');

  static final SINGLE_FILE_UPLOAD = gql(r'''
  mutation($imageId: Float!) {
  updateUserImage(imageId: $imageId) {
  
  }
}
''');

  static final MULTI_FILE_UPLOAD = gql(r'''
  mutation MultiFileUpload($datas: [InputUpload!]) {
    multiFileUpload(datas: $datas) {
      uid
      name
      url
      status
    }
  }
''');

  static final SINGLE_FILE_REMOVE = gql(r'''
  mutation SingleFileRemove($Key: String!) {
    singleFileRemove(Key: $Key)
  }
''');

  static final MULTI_FILE_REMOVE = gql(r'''
  mutation MultiFileRemove($Keys: [String!]) {
    multiFileRemove(Keys: $Keys)
  }
''');
}

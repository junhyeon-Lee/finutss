import 'package:finutss/data/graphql_operation/fragment/Fragments.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UserQueries {
  static final USER = gql(r'''
   query  {
    getUser {
        ...UserFragment
    }
   }
'''
      '''${Fragments.userFragment}''');
  static final USER_BMI = gql(r'''
   query UserBMI() {
    userBMI()
  }
''');
  static final USER_ONE = gql(r'''
  query UserOne($findQuery: JSON) {
    userOne(findQuery: $findQuery) {
      ...UserFragment
      mainParent {
        ...UserFragment
      }
      parents {
        ...UserFragment
      }
      family {
        ...UserFragment
      }
      created {
        ...UserFragment
      }
      updated {
        ...UserFragment
      }
    }
  }
'''
      '''${Fragments.userFragment}''');
  static final USERS = gql(r'''
  query Users($sort: JSON, $findQuery: JSON) {
    users(sort: $sort, findQuery: $findQuery) {
      ...UserFragment
      mainParent {
        ...UserFragment
      }
      parents {
        ...UserFragment
      }
      family {
        ...UserFragment
      }
      created {
        ...UserFragment
      }
      updated {
        ...UserFragment
      }
    }
  }
'''
      '''${Fragments.userFragment}''');

  static final USERS_PAGINATE = gql(r'''
  query {
    getRecommendUsers {
        user_id
        username
        status
        biography
        priority
        birth_date
        email
        image {
            src
        }
        email_verified_at
        phone_number
        role
        created_at
        username
    }
}
''');

  static final USERS_SEARCH = gql(r'''
  query($title: String!) {
    getUsersByUsername(title: $title) {
        user_id
        username
        status
        biography
        priority
        birth_date
        email
        email_verified_at
        phone_number
        role
        created_at
        username
    }
}
''');

  static final HOT_USERS = gql(r'''
  query {
    getHotUsers {
        user_id
        username
        status
        biography
        priority
        birth_date
        email
        image {
            src
        }
        email_verified_at
        phone_number
        role
        created_at
        username
    }
}
''');

  static final CHECK_USER = gql(r'''
  query CheckUser($email: String!) {
    isUserFree(email: $email)
  }
''');

  static final CHECK_USER_INFO = gql(r'''
  query CheckUserInfo($id: ID!, $email: String!, $nickName: String!) {
    checkUserInfo(id: $id, email: $email, nickName: $nickName)
  }
''');

  static final ADD_USER = gql(r'''
  mutation registerUser($data: InputRegister!) {
    registerUser(registerInfo: $data) {
      ...UserFragment
    }
  }
'''
      '''${Fragments.userFragment}''');
  static final ADD_ADMIN = gql(r'''
  mutation AddAdmin($data: InputUser) {
    addAdmin(data: $data) {
      ...UserFragment
      mainParent {
      ...UserFragment
      mainParent {
        ...UserFragment
      }
      parents {
        ...UserFragment
      }
      family {
        ...UserFragment
      }
      created {
        ...UserFragment
      }
      updated {
        ...UserFragment
      }
    }
  }
'''
      '''${Fragments.userFragment}''');

  static final UPDATE_USER = gql(r'''
  mutation UpdateUser($id: ID!, $data: InputUser) {
    updateUser(id: $id, data: $data) {
      ...UserFragment
      mainParent {
        ...UserFragment
      }
      parents {
        ...UserFragment
      }
      family {
        ...UserFragment
      }
      created {
        ...UserFragment
      }
      updated {
        ...UserFragment
      }
    }
  }
'''
      '''${Fragments.userFragment}''');

  static final UPDATE_USER_STATUS = gql(r'''
  mutation UpdateUserStatus($id: ID!, $status: String) {
    updateUserStatus(id: $id, status: $status) {
      ...UserFragment
      mainParent {
        ...UserFragment
      }
      parents {
        ...UserFragment
      }
      family {
        ...UserFragment
      }
      created {
        ...UserFragment
      }
      updated {
        ...UserFragment
      }
    }
  }
'''
      '''${Fragments.userFragment}''');

  static final REMOVE_USER = gql(r'''
  mutation RemoveUser($id: ID!) {
    removeUser(id: $id)
  }
''');

  static final WITHDRAW_USER = gql(r'''
  mutation WithdrawUser($data: InputWithdraw) {
    withdrawUser(data: $data)
  }
''');

  static final UPDATE_PASSWORD = gql(r'''
  mutation UpdatePassword($id: ID!, $refreshToken: String, $password: String) {
    updatePassword(id: $id, refreshToken: $refreshToken ,password: $password)
  }
''');

  static final UPDATE_PASSWORD_APP = gql(r'''
  mutation UpdatePasswordApp($id: Int!, $password: String, $newPassword: String) {
    updatePasswordApp(id: $id, password: $password ,newPassword: $newPassword)
  }
''');

  static final FIND_ID = gql(r'''
  mutation FindId($email: String!) {
    findId(email: $email)
  }
''');

  static final FIND_PWD = gql(r'''
  mutation FindPwd($email: String!) {
    findPwd(email: $email)
  }
''');

  static final UPDATE_USER_BIOGRAPHY = gql(r'''
  mutation($biography: String!) {
    updateUserInfo(biography: $biography) {
        biography
    }
  }
''');

}

// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct InputUserProfile: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - name
  ///   - surname
  public init(name: Swift.Optional<String?> = nil, surname: Swift.Optional<String?> = nil) {
    graphQLMap = ["name": name, "surname": surname]
  }

  public var name: Swift.Optional<String?> {
    get {
      return graphQLMap["name"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var surname: Swift.Optional<String?> {
    get {
      return graphQLMap["surname"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "surname")
    }
  }
}

public final class LoginRequestMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation LoginRequest($phone: String!) {
      UserMutation {
        __typename
        sendCode(phone: $phone)
      }
    }
    """

  public let operationName: String = "LoginRequest"

  public var phone: String

  public init(phone: String) {
    self.phone = phone
  }

  public var variables: GraphQLMap? {
    return ["phone": phone]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("UserMutation", type: .object(UserMutation.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userMutation: UserMutation? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "UserMutation": userMutation.flatMap { (value: UserMutation) -> ResultMap in value.resultMap }])
    }

    public var userMutation: UserMutation? {
      get {
        return (resultMap["UserMutation"] as? ResultMap).flatMap { UserMutation(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "UserMutation")
      }
    }

    public struct UserMutation: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserMutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("sendCode", arguments: ["phone": GraphQLVariable("phone")], type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(sendCode: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserMutation", "sendCode": sendCode])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var sendCode: Bool? {
        get {
          return resultMap["sendCode"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "sendCode")
        }
      }
    }
  }
}

public final class ProfileInfoRequestMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation ProfileInfoRequest($profile: InputUserProfile!) {
      UserMutation {
        __typename
        updateProfile(profile: $profile)
      }
    }
    """

  public let operationName: String = "ProfileInfoRequest"

  public var profile: InputUserProfile

  public init(profile: InputUserProfile) {
    self.profile = profile
  }

  public var variables: GraphQLMap? {
    return ["profile": profile]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("UserMutation", type: .object(UserMutation.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userMutation: UserMutation? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "UserMutation": userMutation.flatMap { (value: UserMutation) -> ResultMap in value.resultMap }])
    }

    public var userMutation: UserMutation? {
      get {
        return (resultMap["UserMutation"] as? ResultMap).flatMap { UserMutation(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "UserMutation")
      }
    }

    public struct UserMutation: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserMutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("updateProfile", arguments: ["profile": GraphQLVariable("profile")], type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(updateProfile: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserMutation", "updateProfile": updateProfile])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var updateProfile: Bool? {
        get {
          return resultMap["updateProfile"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "updateProfile")
        }
      }
    }
  }
}

public final class VerificationRequestMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation VerificationRequest($phone: String!, $code: String!) {
      UserMutation {
        __typename
        confirmCode(phone: $phone, code: $code) {
          __typename
          token
        }
      }
    }
    """

  public let operationName: String = "VerificationRequest"

  public var phone: String
  public var code: String

  public init(phone: String, code: String) {
    self.phone = phone
    self.code = code
  }

  public var variables: GraphQLMap? {
    return ["phone": phone, "code": code]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("UserMutation", type: .object(UserMutation.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userMutation: UserMutation? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "UserMutation": userMutation.flatMap { (value: UserMutation) -> ResultMap in value.resultMap }])
    }

    public var userMutation: UserMutation? {
      get {
        return (resultMap["UserMutation"] as? ResultMap).flatMap { UserMutation(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "UserMutation")
      }
    }

    public struct UserMutation: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserMutation"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("confirmCode", arguments: ["phone": GraphQLVariable("phone"), "code": GraphQLVariable("code")], type: .object(ConfirmCode.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(confirmCode: ConfirmCode? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserMutation", "confirmCode": confirmCode.flatMap { (value: ConfirmCode) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var confirmCode: ConfirmCode? {
        get {
          return (resultMap["confirmCode"] as? ResultMap).flatMap { ConfirmCode(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "confirmCode")
        }
      }

      public struct ConfirmCode: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["JwtTokenResponse"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("token", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(token: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "JwtTokenResponse", "token": token])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var token: String? {
          get {
            return resultMap["token"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "token")
          }
        }
      }
    }
  }
}

public final class ProfileRequestQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query ProfileRequest {
      UserQuery {
        __typename
        getProfile {
          __typename
          phone
          user {
            __typename
            name
            surname
          }
        }
      }
    }
    """

  public let operationName: String = "ProfileRequest"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("UserQuery", type: .object(UserQuery.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(userQuery: UserQuery? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "UserQuery": userQuery.flatMap { (value: UserQuery) -> ResultMap in value.resultMap }])
    }

    public var userQuery: UserQuery? {
      get {
        return (resultMap["UserQuery"] as? ResultMap).flatMap { UserQuery(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "UserQuery")
      }
    }

    public struct UserQuery: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UserQuery"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("getProfile", type: .object(GetProfile.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(getProfile: GetProfile? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserQuery", "getProfile": getProfile.flatMap { (value: GetProfile) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var getProfile: GetProfile? {
        get {
          return (resultMap["getProfile"] as? ResultMap).flatMap { GetProfile(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "getProfile")
        }
      }

      public struct GetProfile: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["UserProfileResponse"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("phone", type: .scalar(String.self)),
            GraphQLField("user", type: .object(User.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(phone: String? = nil, user: User? = nil) {
          self.init(unsafeResultMap: ["__typename": "UserProfileResponse", "phone": phone, "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var phone: String? {
          get {
            return resultMap["phone"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "phone")
          }
        }

        public var user: User? {
          get {
            return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "user")
          }
        }

        public struct User: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["UserProfile"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("surname", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String? = nil, surname: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "UserProfile", "name": name, "surname": surname])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var surname: String? {
            get {
              return resultMap["surname"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "surname")
            }
          }
        }
      }
    }
  }
}

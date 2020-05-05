import 'package:postgres/postgres.dart';

class DataBase {
  final conn = PostgreSQLConnection(
    "10.0.2.2",
    5432,
    "miniproj",
    username: "postgres",
    password: "12345678",
  );

  // returns [error code, user ID]
  Future login(_username, _password) async {
    try {
      print('Logging in...');
      await conn.open();
      final result = await conn.query(
        "SELECT user_id FROM t_accounts WHERE (username = @username OR email = @username) AND password = @password",
        substitutionValues: {"username": _username, "password": _password},
      );
      return (result.length > 0) ? [0, result[0][0]] : [1, null];
    } on PostgreSQLException catch (err) {
      print('PostgreSQLException: $err');
      return [2, null];
    } catch (err) {
      print(err);
      return [2, null];
    }
    finally {
      conn.close();
    }
  }

  // returns Map of data. from tables t_account and t_userdata
  getUserData(_userID) async {
    try {
      print('Getting UserData in...');
      await conn.open();
      final result = await conn.mappedResultsQuery(
        '''
      SELECT 
        t_accounts.user_id,
        t_accounts.username,
        t_accounts.email,
        t_userdata.first_name,
        t_userdata.last_name,
        t_userdata.avatar,
        t_userdata.contact,
        t_location.location_name,
        t_userdata.description
        
      FROM t_accounts
      LEFT JOIN t_userdata ON t_accounts.user_id = t_userdata.user_id
      LEFT Join t_location ON t_accounts.user_id = t_location.user_id
      WHERE t_accounts.user_id = @user_id;
    ''',
        substitutionValues: {"user_id": _userID},
      );
      final userData = {};
      result[0].values.forEach((v) => userData.addAll(v));
      return userData;
    } on PostgreSQLException catch (err) {
      print('PostgreSQLException: $err');
      return {};
    } finally {
      await conn.close();
    }
  }

  search(int userID, {String username, String location, int category}) async {
    if (username != null) {
      location = null;
      category = null;
    } else {
      username = '';
    }
    try {
      print('Searching...');
      await conn.open();
      final result = await conn.query(
        '''
      SELECT 
        DISTINCT t_accounts.user_id,
        t_accounts.username,
        t_userdata.first_name,
        t_userdata.avatar,
        t_userdata.contact,
        t_location.location_name,
        t_userdata.description
		FROM t_accounts
      LEFT JOIN t_userdata ON t_accounts.user_id = t_userdata.user_id
      LEFT JOIN t_location ON t_accounts.user_id = t_location.user_id
	  LEFT JOIN t_user_category ON t_accounts.user_id = t_user_category.user_id
	  WHERE (t_user_category.category_id = (CASE WHEN @category::integer IS NOT NULL THEN @category::integer ELSE category_id END))
	  AND (t_location.location_name = (CASE WHEN @location::text IS NOT NULL THEN @location::text ELSE location_name END))
	  AND (t_accounts.username LIKE (CASE WHEN @username::text IS NOT NULL THEN @username::text ELSE username END) or t_userdata.first_name LIKE (CASE WHEN @username::text IS NOT NULL THEN @username::text ELSE first_name END))
    AND t_accounts.user_id != @userID;
    ''',
        substitutionValues: {
          "userID": userID,
          "username": '%' + username + '%',
          "location": location,
          "category": category
        },
      );

      return result;
    } on PostgreSQLException catch (err) {
      print('PostgreSQLException: $err');
      return {};
    } finally {
      await conn.close();
    }
  }
}

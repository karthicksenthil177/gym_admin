import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final SessionManager _sessionManager = SessionManager._internal();
  static const String _token = 'token';
  static const String _isLoggedIn = 'isLoggedIn';
  static const String _isFirstLogin = 'isFirstLogin';
  static const String _name = 'name';
  static const String _id = "id";

  factory SessionManager() {
    return _sessionManager;
  }

  SessionManager._internal();

  Future<void> setInitialLoginOver(bool firstLogin) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool(_isFirstLogin,firstLogin);
  }

  Future<bool> getInitialLoginOver() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getBool(_isFirstLogin) ?? false;
  }
   setName(String name) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.setString(_name, name);
  }

  Future<String> getName() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getString(_name) ?? "";
  }

  Future<void> setToken(String token) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(_token,token);
  }

  Future<String?> getToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    debugPrint(_pref.getString(_token));
    return _pref.getString(_token) ?? "";
  }

  Future<void> setLoggedInStatus(bool isLoggedIn) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool(_isLoggedIn,isLoggedIn);
  }

  Future<bool> getLoggedInStatus() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    return _pref.getBool(_isLoggedIn) ?? false;
  }

  Future<void> setId(String id) async{
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString(_id,id);
  }

  Future<String> getId() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    debugPrint(_pref.getString(_id));
    return _pref.getString(_id) ?? "";
  }

  void clearAll() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.clear();
  }
}

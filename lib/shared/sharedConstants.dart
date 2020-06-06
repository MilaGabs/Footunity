import 'package:dart_amqp/dart_amqp.dart';

const String LoginKey = 'loginDataKey';
const String AuthKey = 'authDataKey';
const String AuthAPILink = 'http://footunity.ddns.net:120/api/auth';
const String FootAPILink = 'http://footunity.ddns.net:120/api/';
const String RabbitMQHost = 'footunity.ddns.net';
const PlainAuthenticator RabbitMQAuth = PlainAuthenticator("admin", "senhabemsecreta");
const int RabbitMQPort = 5672;
import 'dart:async';
import 'dart:convert';

class ProdutosApi{

  Future <List> loadProduto() async{

    String json = "[  \n" +
        "   {  \n" +
        "      \"id\":\"23658\",\n" +
        "      \"tittle\":\"Nike 270\",\n" +
        "      \"description\":\"Teste teste\",\n" +
        "      \"url_img\":\"http://104.131.18.84/notice/uploads/news/1fd055d2a109fe18af4414bf87293575.jpg\",\n" +
        "      \"price\":\"200,00\",\n" +
        "   }\n" +
        // "   {  \n" +
        // "      \"id\":\"23670\",\n" +
        // "      \"tittle\":\"Nike 270\",\n" +
        // "      \"description\":\"Teste teste\",\n" +
        // "      \"url_img\":\"http://104.131.18.84/notice/uploads/news/1fd055d2a109fe18af4414bf87293575.jpg\",\n" +
        // "      \"price\":\"200,00\",\n" +
        // "   },\n" +
        // "   {  \n" +
        // "      \"id\":\"23671\",\n" +
        // "      \"tittle\":\"Nike 270\",\n" +
        // "      \"description\":\"Teste teste\",\n" +
        // "      \"url_img\":\"http://104.131.18.84/notice/uploads/news/1fd055d2a109fe18af4414bf87293575.jpg\",\n" +
        // "      \"price\":\"200,00\",\n" +
        // "   },\n" +
        // "   {  \n" +
        // "      \"id\":\"23673\",\n" +
        // "      \"tittle\":\"Nike 270\",\n" +
        // "      \"description\":\"Teste teste\",\n" +
        // "      \"url_img\":\"http://104.131.18.84/notice/uploads/news/1fd055d2a109fe18af4414bf87293575.jpg\",\n" +
        // "      \"price\":\"200,00\",\n" +
        // "   }\n" +
        "]";

    return jsonDecode(json);

  }

}
#include "RemoteSongs.hh"
#include "configuration.hh"

#include <curl/curl.h>

#include <iostream>

size_t write_data(void *buffer, size_t size, size_t nmemb, void *userp)
{
  std::vector<char>* pData = reinterpret_cast<std::vector<char>*>(userp);
  char* bytes = reinterpret_cast<char*>(buffer);
  std::vector<char>::size_type pos = pData->size();
  pData->resize( pData->size() + size * nmemb );
  memcpy(&*pData->begin() + pos,buffer, size*nmemb );
  return size * nmemb;
}

RemoteSongs::RemoteSongs( )
{
  std::cout << "RemoteSongs/notice: howdy" << std::endl;
  std::string url = config["game/song-server"].s() + "cache.json";
  std::vector<char> cacheJson;

  CURL * curl = curl_easy_init();
  curl_easy_setopt(curl, CURLOPT_URL, url.c_str() );
  curl_easy_setopt(curl, CURLOPT_WRITEDATA, &cacheJson);
  curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_data);

  std::cout << "RemoteSongs/notice: downloading:" << url << std::endl;

  CURLcode res = curl_easy_perform(curl);
  std::cout << "RemoteSongs/notice: result:" << res << std::endl;
  std::cout << "RemoteSongs/notice: bytes downloaded:" << cacheJson.size() << std::endl;
  curl_easy_cleanup(curl);
}

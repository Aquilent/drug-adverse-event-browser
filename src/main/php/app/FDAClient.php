<?php namespace App;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;

class FDAClient {

  protected $client;

  protected $baseUri = 'https://api.fda.gov';
  protected $drugUrl = '/drug/event.json';
  protected $count = 0;

  public function __construct() {
    $this->client = new Client(['base_uri' => $this->baseUri]);
  }

  public function getResults($query) {
    try {
      $response = $this->sendQuery($query);
      return $response->results;
    }
    catch(ClientException $e) {
      if ($e->getCode() == 404 || $e->getCode() == 400) return [];
      throw $e;
    }
  }

  public function getTotal($query) {
    try {
      $response = $this->sendQuery($query);
      return $response->meta->results->total;
    }
    catch(ClientException $e) {
      if ($e->getCode() == 404 || $e->getCode() == 400) return 0;
      throw $e;
    }
  }
  
  protected function sendQuery($query, $retry = true) {
    $url = $this->formatUrl($query);
    info('Requesting: ' . $url);

    try {
      $response = $this->client->get($url);
    }
    catch(ClientException $e) {
      // Wait one second and retry the request if we recieve a 429 error
      if (($e->getCode() == 429) && $retry) {
        info('too many requests.... retrying query');;
        sleep(1);
        return $this->sendQuery($query, false);
      }

      $message = json_decode($e->getResponse()->getBody()->getContents())->error->message;
      logger()->error($message, compact('url'));
      throw $e;
    }

    return json_decode($response->getBody()->getContents());
  }

  public function formatUrl($query) {
    $url = $this->baseUri . $this->drugUrl . '?' . $this->getAPIKey();
    foreach($query AS $param => $value) {
      $url .= '&' . $param . '=' . $value;
    }
    return $url;
  }

  protected function getAPIKey() {
    if (env('OPENFDA_API_KEY')) {
      $keys = explode(',', env('OPENFDA_API_KEY'));
      $index = $this->count++ % count($keys);
      return 'api_key=' . trim($keys[$index]);
    }
  }
}
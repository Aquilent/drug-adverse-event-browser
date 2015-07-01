<?php namespace App;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;
use Carbon\Carbon;

class FDAClient {

  protected $client;

  protected $baseUri = 'https://api.fda.gov';
  protected $drugUrl = '/drug/event.json';

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
  
  protected function sendQuery($query, $excludeMeta = true) {
    $url = $this->formatUrl($query);
    info('Requesting: ' . $url);

    try {
      $response = $this->client->get($url);
    }
    catch(ClientException $e) {
      $message = json_decode($e->getResponse()->getBody()->getContents())->error->message;
      logger()->error($message, compact('url'));
      throw $e;
    }

    return json_decode($response->getBody()->getContents());
  }

  protected function formatUrl($query) {
    $url = $this->baseUri . $this->drugUrl . '?' . $this->getAPIKey();
    foreach($query AS $param => $value) {
      $url .= '&' . $param . '=' . $value;
    }
    return $url;
  }

  protected function getAPIKey() {
    if (env('OPENFDA_API_KEY')) {
      $keys = explode(',', env('OPENFDA_API_KEY'));
      $index = Carbon::now()->second % count($keys);
      info('info: ' . $keys[$index]);
      return 'api_key=' . trim($keys[$index]);
    }
  }
}
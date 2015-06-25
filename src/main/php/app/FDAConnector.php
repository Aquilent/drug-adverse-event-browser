<?php namespace App;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;

class FDAConnector {

  protected $client;

  protected $baseUri = 'https://api.fda.gov';
  protected $drugUrl = '/drug/event.json';

  public function __construct() {
    $this->client = new Client(['base_uri' => $this->baseUri]);
  }

  public function getDrugReactions($drug) {
    return $this->sendQuery([
      'search' => 'patient.drug.openfda.brand_name:' . $this->formatQueryString($drug),
      'count'  => 'patient.reaction.reactionmeddrapt.exact'
    ]);
  }

  public function getDrugReactionInteractions($drug, $reaction) {
    return $this->sendQuery([
      'search' => '(patient.drug.openfda.brand_name:' . $this->formatQueryString($drug) . '+AND+patient.reaction.reactionmeddrapt:' . $this->formatQueryString($reaction) . ')',
      'count'  => 'patient.drug.openfda.brand_name.exact',
    ]);
  }
  
  protected function sendQuery($query) {
    $url = $this->formatUrl($query);
    info('Requesting: ' . $url);

    try {
      $response = $this->client->get($url);
    }
    catch(ClientException $e) {
      $message = json_decode($e->getResponse()->getBody()->getContents())->error->message;
      logger()->error($message, compact('url'));
      return [];
    }

    return json_decode($response->getBody()->getContents())->results;
  }

  protected function formatUrl($query) {
    $url = $this->baseUri . $this->drugUrl . '?';
    foreach($query AS $param => $value) {
      $url .= '&' . $param . '=' . $value;
    }
    return $url;
  }

  protected function formatQueryString($string) {
    return '"' . str_replace(' ', '+', strtoupper($string)) . '"';
  }
}
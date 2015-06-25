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

  public function getDrugReactions($drugOne, $drugTwo = null) {
    return $this->sendQuery([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo),
      'count'  => 'patient.reaction.reactionmeddrapt.exact'
    ]);
  }

  public function getDrugReactionInteractions($reaction, $drugOne, $drugTwo = null) {
    $interactions =  $this->sendQuery([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction),
      'count'  => 'patient.drug.medicinalproduct.exact',
    ]);

    // First interaction will always be drugOne
    array_shift($interactions);

    // Second interaction will be drugTwo when passed
    if ($drugTwo) array_shift($interactions);

    return $interactions;
  }

  protected function buildSearchTerm($drugOne, $drugTwo = null , $reaction = null) {
    $term = 'patient.drug.medicinalproduct.exact:' . $this->formatQueryString($drugOne);
    if ($drugTwo) $term .= '+AND+patient.drug.medicinalproduct.exact:' . $this->formatQueryString($drugTwo); 
    if ($reaction) $term .= '+AND+patient.reaction.reactionmeddrapt.exact:' . $this->formatQueryString($reaction);

    return '(' . $term . ')';
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
    $url = $this->baseUri . $this->drugUrl . '?' . $this->getAPIKey();
    foreach($query AS $param => $value) {
      $url .= '&' . $param . '=' . $value;
    }
    return $url;
  }

  protected function formatQueryString($string) {
    return '"' . str_replace(' ', '+', strtoupper($string)) . '"';
  }

  protected function getAPIKey() {
    if ($key = env('OPENFDA_API_KEY')) return 'api_key=' . $key;
  }
}
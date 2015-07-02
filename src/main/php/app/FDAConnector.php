<?php namespace App;

use GuzzleHttp\Client;
use GuzzleHttp\Exception\ClientException;

class FDAConnector {

  protected $client;

  public function __construct(FDAClient $client) {
    $this->client = $client;
  }

  public function getDrugReactions($drugOne, $drugTwo = null) {
    return $this->client->getResults([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo),
      'count'  => 'patient.reaction.reactionmeddrapt.exact'
    ]);
  }

  public function getDrugReactionTotal($reaction, $drugOne, $drugTwo = null) {
    return $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction),
    ]);
  }

  public function getDrugReactionInteractions($reaction, $drugOne, $drugTwo = null) {
    $interactions =  $this->client->getResults([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction),
      'count'  => 'patient.drug.medicinalproduct.exact',
    ]);

    // First interaction will always be drugOne
    array_shift($interactions);

    // Second interaction will be drugTwo when passed
    if ($drugTwo) array_shift($interactions);

    return $interactions;
  }

  public function getDrugReactionGender($reaction, $drugOne, $drugTwo = null) {
    $totals['Male'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+patient.patientsex:1',
    ]);

    $totals['Female'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+patient.patientsex:2',
    ]);

    $totals['Unknown'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+patient.patientsex:0',
    ]);

    $totals['Not Reported'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+_missing_:patient.patientsex',
    ]);

    return $this->formatReturn($totals);
  }

  public function getDrugReactionAge($reaction, $drugOne, $drugTwo = null) {
    $totals['< 1'] =  $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildAgeSearchTerm(-100, 1)
    ]);

    $totals['1 to 17'] =  $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildAgeSearchTerm(1, 18)
    ]);

    $totals['18 to 34'] =  $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildAgeSearchTerm(18, 35)
    ]);

    $totals['35 to 54'] =  $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildAgeSearchTerm(35, 55)
    ]);

    $totals['55 to 64'] =  $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildAgeSearchTerm(55, 65)
    ]);

    $totals['> 65'] =  $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildAgeSearchTerm(65, 10000)
    ]);

    $totals['Not Reported'] =  $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+_missing_:(patient.patientonsetage+patient.patientonsetageunit)'
    ]);

    return $this->formatReturn($totals);
  }

  public function getDrugReactionWeight($reaction, $drugOne, $drugTwo = null) {

    $totals[' < 50 LBS'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildWeightSearchTerm(0, 50),
    ]);

    $totals['50 to 99 LBS'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildWeightSearchTerm(50, 100),
    ]);

    $totals['100 to 149 LBS'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildWeightSearchTerm(100, 150),
    ]);

    $totals['150 to 199 LBS'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildWeightSearchTerm(150, 200),
    ]);

    $totals['200 to 249 LBS'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildWeightSearchTerm(200, 250),
    ]);

    $totals['> 250 LBS'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+' . $this->buildWeightSearchTerm(250, 10000),
    ]);

    $totals['Not Reported'] = $this->client->getTotal([
      'search' => $this->buildSearchTerm($drugOne, $drugTwo, $reaction) . '+AND+_missing_:patient.patientweight',
    ]);

    return $this->formatReturn($totals);
  }

  protected function buildSearchTerm($drugOne, $drugTwo = null , $reaction = null) {
    $term = 'patient.drug.medicinalproduct.exact:' . $this->formatQueryString($drugOne);
    if ($drugTwo) $term .= '+AND+patient.drug.medicinalproduct.exact:' . $this->formatQueryString($drugTwo); 
    if ($reaction) $term .= '+AND+patient.reaction.reactionmeddrapt.exact:' . $this->formatQueryString($reaction);

    return '(' . $term . ')';
  }

  protected function buildAgeSearchTerm($from, $to) {
    $delta = .001;

    $terms[] = '(patient.patientonsetageunit:800+AND+patient.patientonsetage:[' . ($from * .1) . '+TO+' . (($to * .1) - $delta) . '])';
    $terms[] = '(patient.patientonsetageunit:801+AND+patient.patientonsetage:[' . ($from) . '+TO+' . (($to) - $delta) . '])';
    $terms[] = '(patient.patientonsetageunit:802+AND+patient.patientonsetage:[' . ($from * 12) . '+TO+' . (($to * 12) - $delta) . '])';
    $terms[] = '(patient.patientonsetageunit:803+AND+patient.patientonsetage:[' . ($from * 52) . '+TO+' . (($to * 52) - $delta) . '])';
    $terms[] = '(patient.patientonsetageunit:804+AND+patient.patientonsetage:[' . ($from * 365) . '+TO+' . (($to * 365) - $delta) . '])';
    $terms[] = '(patient.patientonsetageunit:805+AND+patient.patientonsetage:[' . ($from * 8760) . '+TO+' . (($to * 8760) - $delta) . '])';
    return '(' . implode('+', $terms) . ')';
  }

  protected function buildWeightSearchTerm($from, $to) {
    return '(patient.patientweight:[' . ($from * 0.453592) . '+TO+' . (($to * 0.453592) - .001) . '])';
  }

  protected function formatQueryString($string) {
    return '"' . str_replace(' ', '+', strtoupper($string)) . '"';
  }

  protected function formatReturn($totals) {
    foreach($totals AS $key => $total) {
      $return[] = (object) ['term'=> $key, 'count'=> $total];
    }
    return $return;
  }

}
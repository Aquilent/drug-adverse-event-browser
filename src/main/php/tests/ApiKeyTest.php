<?php

use App\FDAClient;
use Carbon\Carbon;

class ApiKeyTest extends TestCase {

	public function setUp()
	{
		parent::setUp();

	  $this->apiKey = env('OPENFDA_API_KEY');
	}

	public function tearDown()
	{
	  putenv('OPENFDA_API_KEY=' . $this->apiKey);

	  parent::tearDown();
	}

	/**
	 * Tests that when no key is set, we don't add anything to the api query
	 *
	 * @return void
	 */
	public function testNoKey()
	{
		putenv('OPENFDA_API_KEY=');

		$client = new FDAClient();

		$this->assertNotContains('api_key', $client->formatUrl([]));
	}

	/**
	 * Tests that when a key is set it is added to the api query
	 *
	 * @return void
	 */
	public function testOneKey()
	{
		putenv('OPENFDA_API_KEY=API_KEY1');

		$client = new FDAClient();

		$this->assertContains('api_key=API_KEY1', $client->formatUrl([]));
	}

	/**
	 * Tests that multiple keys are cycled
	 *
	 * @return void
	 */
	public function testMultipleKeys()
	{
		$keys = ['API_KEY1', 'API_KEY2', 'API_KEY3'];

		putenv('OPENFDA_API_KEY=' . implode(',', $keys));

		$client = new FDAClient();
		foreach($keys AS $key) {
			$this->assertContains('api_key=' . $key, $client->formatUrl([]));
		}
	}

}

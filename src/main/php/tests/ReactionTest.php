<?php

class ReactionTest extends TestCase {

	public function setUp()
	{
		parent::setUp();

	  Session::start();
	}

	/**
	 * Test that a error is returned when an empty search is submitted
	 *
	 * @return void
	 */
	public function testEmptySubmit()
	{
		$response = $this->call('POST', '/', [ '_token' => csrf_token() ]);

		$this->assertRedirectedToRoute('home');
		$this->assertSessionHas('error', 'Please enter at least one drug name for your search.');
	}

	/**
	 * Tests that a submit redirects to the listReactions page
	 *
	 * @return void
	 */
	public function testSubmit()
	{
		$response = $this->call('POST', '/', [ '_token' => csrf_token(), 'drugOne' => 'Ibuprofen' ]);
		$this->assertRedirectedToRoute('listReactions', ['Ibuprofen']);

		$response = $this->call('POST', '/', [ '_token' => csrf_token(), 'drugOne' => 'Ibuprofen', 'drugTwo' => 'Advil' ]);
		$this->assertRedirectedToRoute('listReactions', ['Ibuprofen', 'Advil']);

		$response = $this->call('POST', '/', [ '_token' => csrf_token(), 'drugTwo' => 'Advil' ]);
		$this->assertRedirectedToRoute('listReactions', ['Advil']);
	}

	/**
	 * Test that ListReactions with one drug calls the correct backend function
	 *
	 * @return void
	 */
	public function testListReactionsOneDrug()
	{
		$this->mock('App\FDAConnector')->shouldReceive('getDrugReactions')->with('Ibuprofen', null)->once();

		$response = $this->route('GET', 'listReactions', ['Ibuprofen']);
	}

	/**
	 * Test that ListReactions with two drugs calls the correct backend function
	 *
	 * @return void
	 */
	public function testListReactionsTwoDrugs()
	{
		$this->mock('App\FDAConnector')->shouldReceive('getDrugReactions')->with('Ibuprofen', 'Advil')->once();

		$response = $this->route('GET', 'listReactions', ['Ibuprofen', 'Advil']);
	}

	/**
	 * Test that when empty array is returned resulting page displays no results found text
	 *
	 * @return void
	 */
	public function testNoResultsFound()
	{
		$this->mock('App\FDAConnector')->shouldReceive('getDrugReactions')->with('Ibuprofen', 'Advil')->once()->andReturn([]);

		$response = $this->route('GET', 'listReactions', ['Ibuprofen', 'Advil']);

		$this->assertContains('No results found.', $response->getContent());
	}

}

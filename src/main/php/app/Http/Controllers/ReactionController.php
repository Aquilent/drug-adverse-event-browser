<?php namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\FDAConnector;

class ReactionController extends Controller {

	/*
	|--------------------------------------------------------------------------
	| Welcome Controller
	|--------------------------------------------------------------------------
	|
	| This controller renders the "marketing page" for the application and
	| is configured to only allow guests. Like most of the other sample
	| controllers, you are free to modify or remove it as you desire.
	|
	*/

	/**
	 * Create a new controller instance.
	 *
	 * @return void
	 */
	public function __construct()
	{
		$this->middleware('guest');
	}

	/**
	 * Show the application welcome screen to the user.
	 *
	 * @return Response
	 */
	public function getReactions(Request $request)
	{
		return redirect()->route('listReactions', [ trim($request->drugOne), trim($request->drugTwo) ]);
	}

	/**
	 * Show the application welcome screen to the user.
	 *
	 * @return Response
	 */
	public function listReactions(Request $request, $drugOne, $drugTwo = null)
	{
		$connector = new FDAConnector();

		$reactions = $this->limitResults($connector->getDrugReactions($drugOne, $drugTwo));
		
		return view('reactions', compact('drugOne', 'drugTwo', 'reactions'));
	}

	/**
	 * Show the application welcome screen to the user.
	 *
	 * @return Response
	 */
	public function listInteractions(Request $request, $reaction, $drugOne, $drugTwo = null)
	{
		$connector = new FDAConnector();

		$data = [
			'drugOne'		=>	$drugOne,
			'drugTwo'		=>	$drugTwo,
			'reaction' 	=> 	$reaction,
			'total'			=> 	$connector->getDrugReactionTotal($reaction, $drugOne, $drugTwo),
			'genders'		=>	$connector->getDrugReactionGender($reaction, $drugOne, $drugTwo),
			'ages'			=>	$connector->getDrugReactionAge($reaction, $drugOne, $drugTwo),
			'weights'		=>	$connector->getDrugReactionWeight($reaction, $drugOne, $drugTwo)
		];

		return view('demographics', $data);

		//$interactions = $this->limitResults($connector->getDrugReactionInteractions($reaction, $drugOne, $drugTwo));
		
		//return view('interactions', compact('drugOne', 'drugTwo', 'reaction', 'interactions'));
	} 

	/**
	 * Show the application welcome screen to the user.
	 *
	 * @return Response
	 */
	protected function limitResults($results) 
	{
		if (app('request')->get('show') == 'all') return $results;

		return collect($results)->take(10)->toArray();
	}

}

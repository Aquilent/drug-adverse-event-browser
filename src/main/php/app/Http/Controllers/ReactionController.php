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

	protected $fda;

	/**
	 * Create a new controller instance.
	 *
	 * @return void
	 */
	public function __construct(FDAConnector $fda)
	{
		$this->fda = $fda;
		$this->middleware('guest');
	}

	/**
	 * Show the application welcome screen to the user.
	 *
	 * @return Response
	 */
	public function getReactions(Request $request)
	{
		if (!($request->has('drugOne') || $request->has('drugTwo'))) {
			return redirect()->route('home')->withError('Please enter at least one drug name for your search.');
		}

		return redirect()->route('listReactions', [ trim($request->drugOne), trim($request->drugTwo) ]);
	}

	/**
	 * Show the application welcome screen to the user.
	 *
	 * @return Response
	 */
	public function listReactions(Request $request, $drugOne, $drugTwo = null)
	{
		session()->flash('show', $request->get('show'));

		$reactions = $this->limitResults($this->fda->getDrugReactions($drugOne, $drugTwo));
		
		return view('reactions', compact('drugOne', 'drugTwo', 'reactions'));
	}

	/**
	 * Show the application welcome screen to the user.
	 *
	 * @return Response
	 */
	public function listInteractions(Request $request, $reaction, $drugOne, $drugTwo = null)
	{
		$data = [
			'drugOne'		=>	$drugOne,
			'drugTwo'		=>	$drugTwo,
			'reaction' 	=> 	$reaction,
			'total'			=> 	$this->fda->getDrugReactionTotal($reaction, $drugOne, $drugTwo),
			'genders'		=>	$this->fda->getDrugReactionGender($reaction, $drugOne, $drugTwo),
			'ages'			=>	$this->fda->getDrugReactionAge($reaction, $drugOne, $drugTwo),
			'weights'		=>	$this->fda->getDrugReactionWeight($reaction, $drugOne, $drugTwo)
		];

		return view('demographics', $data);
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

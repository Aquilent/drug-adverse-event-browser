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
		return redirect()->route('listReactions', [ format_title($request->drug) ]);
	}

	/**
	 * Show the application welcome screen to the user.
	 *
	 * @return Response
	 */
	public function listReactions(Request $request, $drug)
	{
		$connector = new FDAConnector();
		$reactions = $this->limitResults($connector->getDrugReactions($drug));
		
		return view('reactions', compact('drug', 'reactions'));
	}

	/**
	 * Show the application welcome screen to the user.
	 *
	 * @return Response
	 */
	public function listInteractions(Request $request, $drug, $reaction)
	{
		$connector = new FDAConnector();
		$interactions = $this->limitResults($connector->getDrugReactionInteractions($drug, $reaction));
		
		return view('interactions', compact('drug', 'reaction', 'interactions'));
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
